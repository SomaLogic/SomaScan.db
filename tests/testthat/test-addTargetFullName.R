# Setup ------------
seqs <- withr::with_seed(123, sample(keys(SomaScan.db), 3))
df <- quiet(select(SomaScan.db, seqs, c("ENTREZID", "PATH"), menu = "7k"))
res <- addTargetFullName(df)

# Testing ---------
test_that("`addTargetFullName()` correctly inserts Target Full Name info", {
    expect_equal(ncol(res), 4L)
    expect_named(res, c("PROBEID", "TARGETFULLNAME", "ENTREZID", "PATH"))
    expect_identical(res$TARGETFULLNAME, c("Prostaglandin reductase 2",
                                           "Proline-serine-threonine phosphatase-interacting protein 1",
                                           rep("Sepiapterin reductase", 2)))
})
