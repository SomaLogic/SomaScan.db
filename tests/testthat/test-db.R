# Setup ------------
library(DBI)

# Retrieval functions
getProbes <- function() {
    require("SomaScan.db")
    as.numeric(dbGetQuery(
        dbconn(SomaScan.db),
        "SELECT count(DISTINCT probe_id) FROM probes"
    ))
}

getGenes <- function() {
    require("SomaScan.db")
    as.numeric(dbGetQuery(
        dbconn(SomaScan.db),
        "SELECT count(DISTINCT gene_id) FROM probes"
    ))
}

# Error messages
probeMsg <- paste("This package has no probes. This can be caused by a large", 
                  "number of upstream changes. But it's usually caused by", 
                  "alterations to the source files used to extract the probes",
                  "at the very beginning.",
                  sep = ""
)

geneMsg <- paste("This package has no genes. This can be caused by a large",
                 "number of upstream changes. But it's usually caused by", 
                 "alterations to the source files used to extract the probes", 
                 "at the very beginning.",
                 sep = ""
)


# Testing ----------
test_that("Verify probes and genes exist (for chip packages)", {
    expect_true(getProbes() > 0,
                label = paste(strwrap(probeMsg, exdent = 2), collapse = "\n")
    )
    
    expect_true(getGenes() > 0,
                label = paste(strwrap(geneMsg, exdent = 2), collapse = "\n")
    )
})

test_that("Verify number of probes is as expected", {
    # Note: these values will NOT match the total number of analytes in the 
    # menu tool (and that is expected), as this package excludes 
    # non-human analytes
    all_probeIDs <- keys(SomaScan.db)
    sel_probeIDs <- select(SomaScan.db, keys = keys(SomaScan.db), 
                           columns = "PROBEID")
    sql_probeIDs <- getProbes()
    v4.1_probeIDs <- select(SomaScan.db, keys = keys(SomaScan.db), 
                            columns = "PROBEID", menu = "v4.1")
    v4.0_probeIDs <- select(SomaScan.db, keys = keys(SomaScan.db), 
                            columns = "PROBEID", menu = "v4.0")
    
    # All methods below should retrieve same number of probes
    expect_length(all_probeIDs, 7267L)
    expect_length(sel_probeIDs$PROBEID, 7267L)
    expect_equal(sql_probeIDs, 7267L)
    
    # Lengths should differ by menu version
    expect_length(v4.1_probeIDs$PROBEID, 7267L)
    expect_length(v4.0_probeIDs$PROBEID, 4966L)
})

test_that("SQLite database environment variables are set correctly", {
    expect_s4_class(SomaScan_dbconn(), "SQLiteConnection")
    expect_type(SomaScan_dbfile(), "character")  
    expect_s3_class(SomaScan_dbInfo(), "data.frame")
})
