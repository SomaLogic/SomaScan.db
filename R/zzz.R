datacache <- new.env(hash = TRUE, parent = emptyenv())

SomaScan <- function() showQCData("SomaScan", datacache)
SomaScan_dbconn <- function() dbconn(datacache)
SomaScan_dbfile <- function() dbfile(datacache)
SomaScan_dbschema <- function(file = "", show.indices = FALSE) {
    dbschema(datacache, file = file, show.indices = show.indices)
}
SomaScan_dbInfo <- function() dbInfo(datacache)

SomaScanORGANISM <- "Homo sapiens"

####################################################

.onLoad <- function(libname, pkgname) {
    # Loads data objects when package is loaded 
    # (alternative to LazyData = TRUE)
    utils::data("somascan_menu",
                package = "SomaScan.db",
                envir = parent.env(environment())
    )
    
    # Connect to the SQLite DB
    dbfile <- system.file("extdata", "SomaScan.sqlite", 
                          package = pkgname, lib.loc = libname)
    assign("dbfile", dbfile, envir = datacache)
    dbconn <- dbFileConnect(dbfile)
    assign("dbconn", dbconn, envir = datacache)
    
    # Create the SomaDb object
    sPkgname <- sub(".db$", "", pkgname)
    smdb <- new("SomaDb", conn = dbconn, packageName = pkgname)
    
    # Rename SQLite db to have the same name as the package
    dbNewname <- pkgname
    ns <- asNamespace(pkgname)
    assign(dbNewname, smdb, envir = ns)
    namespaceExport(ns, dbNewname)
    
    # Create the AnnObj instances
    ann_objs <- createAnnObjs.SchemaChoice("HUMANCHIP_DB", "SomaScan", 
                                           "chip SomaScan", dbconn, datacache)
    ann_objs$SomaScanUNIPROT2PROBE <- revmap(ann_objs$SomaScanUNIPROT, 
                                             objName = "UNIPROT2PROBE")
    
    # Remove from env if not using in package
    rmv <- grep("PROSITE|PFAM|CHR|ACCNUM|MAPCOUNTS", 
                ls(ann_objs), value = TRUE) 
    rm(list = rmv, envir = ann_objs)
    
    mergeToNamespaceAndExport(ann_objs, pkgname) 
}

##################################################

.onUnload <- function(libpath) {
    dbFileDisconnect(SomaScan_dbconn())
}

##################################################

# Create mapping for full name of protein target
SomaScanTARGETFULLNAME <- createSimpleBimap(tablename = "target_names",
                                            Lcolname  = "probe_id",
                                            Rcolname  = "target_full_name",
                                            datacache = datacache,
                                            objName   = "TARGETFULLNAME",
                                            objTarget = "SomaScan.db")
