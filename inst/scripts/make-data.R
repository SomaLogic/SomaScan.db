
# ---------- Load packages and set up -------#
library(AnnotationDbi)
library(AnnotationForge)
library(DBI)
library(human.db0)

regenerateDB <- function(file, dest, ver, overwrite = TRUE) {
    temp_db <- tempdir()
    withr::with_dir(temp_db,
                    AnnotationForge::makeDBPackage("HUMANCHIP_DB",
                                                   affy = FALSE,
                                                   prefix = "SomaScan",
                                                   fileName = file,
                                                   # Using Entrez Gene IDs
                                                   baseMapType = "eg", 
                                                   version = ver,
                                                   manufacturer = "SomaLogic",
                                                   chipName = "SomaScan",
                                                   manufacturerUrl = "https://somalogic.com/somascan-platform/",
                                                   author = "Amanda Hiser"))
    file.copy(from = file.path(temp_db, "SomaScan.sqlite"), to = dest, 
              overwrite = overwrite)
    unlink(temp_db, recursive = TRUE)
}

# ---------- Input data ----------------------#
# Up-to-date analyte lists from past SomaScan menu releases will be used to
# generate the SQLite annotation database. The original document used to 
# generate these files is available to SomaLogic customers only. 
# However, the full menu and extended annotations can be explored 
# at https://menu.somalogic.com/.

# The files below were created by selecting the "SeqId", "Entrez Gene ID", and
# "Target Full Name" columns from the official SomaScan menu document, using
# both the 5k (v4.0) and 7k (v4.1) assay menus.
# Note: these files must NOT have column headers
files <- list(menu_5k = system.file("extdata/SomaScan_5k_seqIDs_EntrezIDs_targFullNames.txt", 
                                    package = "SomaScan.db", mustWork = TRUE),
              menu_7k = system.file("extdata/SomaScan_7k_seqIDs_EntrezIDs_targFullNames.txt",
                                    package = "SomaScan.db", mustWork = TRUE),
              menu_11k = system.file("extdata/SomaScan_11k_seqIDs_EntrezIDs_targFullNames.txt",
                                     package = "SomaScan.db", mustWork = TRUE))

# Column headers may be added once read into the environment
colnames <- c("probe_id", "entrez_id", "target_full_name")
data <- lapply(files, read.delim, header = FALSE, col.names = colnames)

# The target full name will not initially be needed (to generate the 
# SQLite database)
pkg_input <- data$menu_11k[,1:2]


#----------- Generate SQLite db --------------#
# This database will require a "HUMANCHIP_DB" schema.
# Note: The human.db0 package MUST be installed, or the AnnotationForge 
#.      functions below won't work
grep("HUMAN", available.dbschemas(), value = T)

# Metadata information required to populate a human ChipDb
pkgmeta <- c(DBSCHEMA = "HUMANCHIP_DB",
             ORGANISM = "Human", 
             SPECIES = "Homo sapiens", 
             MANUFACTURER = "SomaLogic", 
             CHIPNAME = "SomaScan", 
             MANUFACTURERURL = "https://somalogic.com/somascan-platform/")

# This package was originally created using the function call below.
# Note: this only needed to be run ONCE
# AnnotationForge::makeDBPackage("HUMANCHIP_DB",
#                                affy = FALSE,
#                                prefix = "SomaScan",
#                                fileName = file,
#                                # Using Entrez Gene IDs
#                                baseMapType = "eg",
#                                # Pre-submission pkg version required by Bioc
#                                version = "0.99.0",
#                                manufacturer = "SomaLogic",
#                                chipName = "SomaScan",
#                                author = "Amanda Hiser")

# When new SomaScan menus are released, the SQLite db must be regenerated to 
# incorporate new annotations. AnnotationForge::populateDB() does not 
# correctly link the PROBEID for ChipDBs - this requires a hacky workaround to 
# re-create the database, ignoring other newly generated package components
regenerateDB(files$menu_11k, 
             dest = "inst/extdata/SomaScan.sqlite", ver = "1.0.0")


# ---------- Create database connection--------------#
con <- dbConnect(dbDriver("SQLite"), "inst/extdata/SomaScan.sqlite")


#----------- Modify metadata --------------#
# This step suggested by the AnnotationForge vignette "Making New Annotation 
# Packages", section 7
dbGetQuery(con, "SELECT * FROM metadata") # Check current metadata
dbSendQuery(con, paste("UPDATE metadata SET value='SomaScan.db' WHERE",
                       "value='AnnotationDbi'"))


#----------- Add tables to database ------------------#
# The 11k version of the SomaScan assay menu encompasses all analytes
# from the previous menus, and as such represents a "superset"
# of all currently available assay analytes and their unique identifiers
superset <- data$menu_11$probe_id

# Create a dataframe to delineate which analytes are available in each 
# version of the menu
menus <- data.frame(probe_id = superset,
                    v4_0 = ifelse(superset %in% data$menu_5k[[1]], 
                                  1, 0),
                    v4_1 = ifelse(superset %in% data$menu_7k[[1]], 
                                  1, 0),
                    v5_0 = ifelse(superset %in% data$menu_11k[[1]], 
                                  1, 0))

# These won't be identical due to probe ID duplicates, 
# but should be in the same ballpark
apply(menus[,-1], 2, sum)
lapply(data, nrow)

# Adding above data as a table to the SQLite database
dbGetQuery(con, paste("CREATE Table map_menu", 
                      "(probe_id TEXT, v4_0 INTEGER, v4_1 INTEGER, v5_0 INTEGER)"))
dbAppendTable(con, "map_menu", menus)

# Adding target full name table to SQLite database
seqId2targName <- data$menu_11k[-which(colnames(data$menu_11k) == "entrez_id")]

# These should be identical
identical(pkg_input$probe_id, seqId2targName$probe_id) 

dbGetQuery(con, paste("CREATE Table target_names", 
                      "(probe_id TEXT, target_full_name TEXT)"))
dbAppendTable(con, "target_names", seqId2targName)


# ------- Close database connection ------#
dbDisconnect(con)
