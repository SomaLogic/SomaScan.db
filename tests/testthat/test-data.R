# Setup ------------
v4.0_analytes <- somascan_menu$v4.0
v4.1_analytes <- somascan_menu$v4.1
v5.0_analytes <- somascan_menu$v5.0
res_5k <- dbEasyQuery(SomaScan_dbconn(), "SELECT * FROM map_menu WHERE v4_0 IS 1")
res_7k <- dbEasyQuery(SomaScan_dbconn(), "SELECT * FROM map_menu WHERE v4_1 IS 1")
res_11k <- dbEasyQuery(SomaScan_dbconn(), "SELECT * FROM map_menu WHERE v5_0 IS 1")


# Testing ----------
test_that("The assay version data object is available in the environment", {
    expect_true(exists("somascan_menu"))
})

test_that("The v4.0 (5k) assay ver data object has the expected characteristics", {
    expect_type(v4.0_analytes, "character")
    expect_length(v4.0_analytes, 4966L)
    expect_true(all(SomaDataIO::is.SeqId(v4.0_analytes)))
})

test_that("The v4.1 (7k) assay ver data object has the expected characteristics", {
    expect_type(v4.1_analytes, "character")
    expect_length(v4.1_analytes, 7267L)
    expect_true(all(SomaDataIO::is.SeqId(v4.1_analytes)))
})

test_that("The v5.0 (11k) assay ver data object has the expected characteristics", {
    expect_type(v5.0_analytes, "character")
    expect_length(v5.0_analytes, 10731L)
    expect_true(all(SomaDataIO::is.SeqId(v5.0_analytes)))
})

test_that("The data objects have the same information as the SQLite db menu table", {
    # Some SeqIds map to >1 UniProt ID in the DB, so need to remove dups w/ unique()
    expect_identical(unique(res_5k$probe_id), v4.0_analytes)
    expect_identical(unique(res_7k$probe_id), v4.1_analytes)
})

test_that("Custom bimaps are available in the environment", {
    expect_true(exists("SomaScanTARGETFULLNAME"))
    expect_true(exists("SomaScanORGANISM"))
    expect_identical(SomaScanORGANISM, "Homo sapiens")
})

test_that("Custom bimaps behave as expected when cast to data.frame", {
    df <- toTable(SomaScanTARGETFULLNAME)
    expect_s3_class(df, "data.frame")
    expect_equal(dim(df), c(10871L, 2L))
    expect_named(df, c("probe_id", "target_full_name"))
})

