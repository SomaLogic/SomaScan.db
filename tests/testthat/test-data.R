# Setup ------------
v4.0_analytes <- somascan_menu$v4.0
v4.1_analytes <- somascan_menu$v4.1
res_5k <- dbEasyQuery(SomaScan_dbconn(), "SELECT * FROM map_menu WHERE v4_0 IS 1")
res_7k <- dbEasyQuery(SomaScan_dbconn(), "SELECT * FROM map_menu WHERE v4_1 IS 1")


# Testing ----------
test_that("The assay version data object is available in the environment", {
    expect_true(exists("somascan_menu"))
})

test_that("The v4.0 assay version data object has the expected characteristics", {
    expect_type(v4.0_analytes, "character")
    expect_length(v4.0_analytes, 4966L)
    expect_true(all(SomaDataIO::is.SeqId(v4.0_analytes)))
})

test_that("The v4.1 assay version data object has the expected characteristics", {
    expect_type(v4.1_analytes, "character")
    expect_length(v4.1_analytes, 7267L)
    expect_true(all(SomaDataIO::is.SeqId(v4.1_analytes)))
})

test_that("The data objects have the same information as the SQLite db menu table", {
    # Some SeqIds map to >1 UniProt ID in the DB, so need to remove dups w/ unique()
    expect_identical(unique(res_5k$probe_id), v4.0_analytes)
    expect_identical(unique(res_7k$probe_id), v4.1_analytes)
})
