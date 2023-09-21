# Setup ------------
seqs <- withr::with_seed(123, sample(keys(SomaScan.db), 3))
df <- select(SomaScan.db, seqs, c("ENTREZID", "PATH"))
res <- addTargetFullName(df)

# Testing ---------
test_that("`addTargetFullName()` correctly inserts Target Full Name info", {
    expect_equal(ncol(res), 4L)
    expect_named(res, c("PROBEID", "TARGETFULLNAME", "ENTREZID", "PATH"))
    expect_identical(res$TARGETFULLNAME, c("NEDD8-conjugating enzyme UBE2F",
                                          "7-methylguanosine phosphate-specific 5'-nucleotidase",
                                          "Nuclear transport factor 2"))
})
