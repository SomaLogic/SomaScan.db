library(SomaScan.db)
library(AnnotationDbi)

# Connecting to db
dbname <- file.path("inst/extdata/SomaScan.sqlite")

sql <- c("SELECT probe_id from map_menu WHERE %s IS 1")

somascan_menu <- list(
    v4.0 = dbGetQuery(SomaScan_dbconn(), sprintf(sql, "v4_0"))$probe_id,
    v4.1 = dbGetQuery(SomaScan_dbconn(), sprintf(sql, "v4_1"))$probe_id
)

# Removing any duplicate entries, only need 1 per analyte
somascan_menu <- lapply(somascan_menu, unique)

# Use the same name for the object & the file. Preferred format is RDA
save(somascan_menu, file = "data/somascan_menu.rda", compress = "xz")
