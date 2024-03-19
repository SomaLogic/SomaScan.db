# Setup ------------
# The SomaScan Menu Tool can be accessed at https://menu.somalogic.com/
cols <- c("UNIPROT", "SYMBOL")


# Testing ---------

# Using SeqIds as query keys
test_that("`select()` returns same results as online menu tool for `10012-5`", {
    # Vector of values returned by the online menu tool
    online_res <- c("10012-5", "O95238", "SPDEF") 
    
    # Results should be the same for this SeqId, regardless of menu
    pkg_res_7k <- quiet(select(SomaScan.db, "10012-5", cols)) |>
        as.character()
    pkg_res_11k <- quiet(select(SomaScan.db, "10012-5", cols, menu = "11k")) |>
        as.character()
    
    expect_identical(pkg_res_7k, pkg_res_11k)
    expect_identical(online_res, pkg_res_11k)
})

test_that("`select()` returns different results from online menu tool using key `10010-10`", {
    # Returns only reviewed Uniprot accessions
    online_res <- c("10010-10", "Q14457", "BECN1") 
    # Returns unreviewed + reviewed Uniprot accessions
    pkg_res <- quiet(select(SomaScan.db, "10010-10", cols, menu = "11k"))
    d <- setdiff(pkg_res$UNIPROT, online_res[2])
    
    expect_equal(d, c("A0A024R1X5", "W0FFG4", "B4DQ36", "E7EV84"))
    expect_false(identical(online_res, pkg_res$UNIPROT))
})

# Using Gene Symbols as query keys
test_that("`select()` returns same symbols as online menu tool for `PTGR1`", {
    online_res <- data.frame(
        Sequence_ID = c("13543-7", "19617-5"),
        Symbol      = c("PTGR1", "PTGR1"),
        Uniprot_ID  = c("Q14914", "Q14914")
    )
    pkg_res <- quiet(
        select(SomaScan.db,
               keys    = "PTGR1",
               keytype = "SYMBOL",
               columns = c("PROBEID", cols),
               menu    = "11k"
        )
    )

    expect_identical(online_res$Symbol, pkg_res$SYMBOL)
    expect_identical(online_res$Sequence_ID, pkg_res$PROBEID)
    expect_identical(online_res$Uniprot_ID, pkg_res$UNIPROT)
})

# Using Uniprot IDs as query keys
test_that("`select()` returns same UniProt IDs as online menu tool for `P15692`", {
    skip("Addition of 11k menu invalidates this test, but it will be retained for future use.")
    online_res <- data.frame(
        Sequence_ID = c("14032-2", "19437-61", "2597-8", "4867-15"),
        Symbol      = c(rep("VEGFA", 4)),
        Uniprot_ID  = rep("P15692", 4)
    )
    # still returning 11k results even when 7k is provided
    # 27201-39 and 27201-39 are 11k analytes....
    pkg_res <- quiet(
        select(SomaScan.db,
               keys    = "P15692",
               keytype = "UNIPROT",
               columns = c("PROBEID", cols),
               menu    = "7k"
        )
    )
    expect_identical(online_res$Symbol, pkg_res$SYMBOL)
    expect_identical(online_res$Sequence_ID, pkg_res$PROBEID)
    expect_identical(online_res$Uniprot_ID, pkg_res$UNIPROT)
})
