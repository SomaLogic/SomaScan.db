devtools::load_all(".")

# Connecting to db
dbname <- file.path("inst/extdata/SomaScan.sqlite")

somascan_menu <- list(
    v4.0 = dbGetQuery(SomaScan_dbconn(), "SELECT probe_id from map_menu WHERE v4_0 IS 1")$probe_id,
    v4.1 = dbGetQuery(SomaScan_dbconn(), "SELECT probe_id from map_menu WHERE v4_1 IS 1")$probe_id
)

# Removing any duplicate entries, only need 1 per analyte
somascan_menu <- lapply(somascan_menu, unique)

# Use the same name for the object & the file. Preferred format is RDA
save(somascan_menu, file = "data/somascan_menu.rda", compress = "xz")
