# Setup ------------
# The SomaScan Menu Tool can be accessed at https://menu.somalogic.com/
cols <- c("UNIPROT", "SYMBOL")


# Testing ---------

# Note: these values will NOT match the total number of analytes in the 
# menu tool (and that is expected), as this package excludes 
# non-human analytes
test_that("The number of probes in the database is as expected", {
    all_keys <- keys(SomaScan.db)
    all_probeIDs <- select(SomaScan.db, keys = keys(SomaScan.db), 
                           columns = "PROBEID")
    v4.1_probeIDs <- select(SomaScan.db, keys = keys(SomaScan.db), 
                            columns = "PROBEID", menu = "v4.1")
    v4.0_probeIDs <- select(SomaScan.db, keys = keys(SomaScan.db), 
                            columns = "PROBEID", menu = "v4.0")
    
    expect_length(all_keys, 7267L)
    expect_length(all_probeIDs$PROBEID, 7267L)
    expect_length(v4.1_probeIDs$PROBEID, 7267L)
    expect_length(v4.0_probeIDs$PROBEID, 4966L)
})

# SeqIds
test_that("`select()` returns same results as online menu tool for `10012-5`", {
    menu_res <- c("10012-5", "O95238", "SPDEF")
    pkg_res <- quiet(select(SomaScan.db, "10012-5", cols))
    pkg_res <- as.character(pkg_res)

    expect_identical(menu_res, pkg_res)
})

test_that("`select()` returns different results from online menu tool for `10010-10`", {
    menu_res <- c("10010-10", "Q14457", "BECN1") # Returns only reviewed Uniprot accessions
    pkg_res <- quiet(select(SomaScan.db, "10010-10", cols)) # Returns unreviewed Uniprot accessions

    d <- setdiff(pkg_res$UNIPROT, menu_res[2])
    expect_length(d, 4L)
})

# Gene symbols
test_that("`select()` returns same results as online menu tool for `PTGR1`", {
    menu_res <- data.frame(
        Sequence_ID = c("13543-7", "19617-5"),
        Symbol = c("PTGR1", "PTGR1"),
        Uniprot_ID = c("Q14914", "Q14914")
    )
    pkg_res <- quiet(
        select(SomaScan.db,
            keys = "PTGR1",
            keytype = "SYMBOL",
            columns = c("PROBEID", cols)
        )
    )

    expect_identical(menu_res$Symbol, pkg_res$SYMBOL)
    expect_identical(menu_res$Sequence_ID, pkg_res$PROBEID)
    expect_identical(menu_res$Uniprot_ID, pkg_res$UNIPROT)
})


# Uniprot IDs
test_that("`select()` returns same results as online menu tool for `P15692`", {
    menu_res <- data.frame(
        Sequence_ID = c("14032-2", "19437-61", "2597-8", "4867-15"),
        Symbol = c(rep("VEGFA", 4)),
        Uniprot_ID = rep("P15692", 4)
    )
    pkg_res <- quiet(
        select(SomaScan.db,
            keys = "P15692",
            keytype = "UNIPROT",
            columns = c("PROBEID", cols)
        )
    )
    expect_identical(menu_res$Symbol, pkg_res$SYMBOL)
    expect_identical(menu_res$Sequence_ID, pkg_res$PROBEID)
    expect_identical(menu_res$Uniprot_ID, pkg_res$UNIPROT)
})
