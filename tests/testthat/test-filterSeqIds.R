# Setup ------------
k <- keys(SomaScan.db) # Uses analyte superset (i.e. 11k menu) by default
v4.0 <- .filterSeqIds(k, menu = "v4.0")
v4.1 <- .filterSeqIds(k, menu = "v4.1")
v5.0 <- .filterSeqIds(k, menu = "v5.0")


# Testing ---------
test_that("`.filterSeqIds()` returns the expected analytes by default", {
    expect_identical(unique(k), somascan_menu$v5.0)
})

test_that("`.filterSeqIds() returns the analytes specified by `menu` argument`", {
    expect_identical(v4.0, somascan_menu$v4.0)
    expect_identical(v4.1, somascan_menu$v4.1)
    expect_identical(v5.0, somascan_menu$v5.0)
})
