# Setup ------------
k <- withr::with_seed(101, sample(keys(SomaScan.db), 100L, replace = FALSE))
any(duplicated(k))

kt <- keytypes(SomaScan.db)
c <- c("UNIPROT", "ENTREZID")

res_def <- quiet(select(SomaScan.db, keys = keys(SomaScan.db), 
                        columns = "PROBEID"))
res_5k <- quiet(select(SomaScan.db, keys = keys(SomaScan.db), 
                       columns = "PROBEID", menu = "v4.0"))
res_7k <- quiet(select(SomaScan.db, keys = keys(SomaScan.db), 
                       columns = "PROBEID", menu = "v4.1"))


# Testing ----------
test_that("`select()` works as expected for a SomaDb class object", {
    res <- quiet(select(SomaScan.db,
        keys = k,
        columns = c("ENSEMBL", "UNIPROT")
    ))
    expect_equal(dim(res), c(283, 3))
    expect_s3_class(res, "data.frame")
    expect_named(res, c("PROBEID", "ENSEMBL", "UNIPROT"))
    expect_equal(head(res$PROBEID), c(
        "20564-53", "20564-53", "5481-16",
        "5481-16", "17792-158", "17792-158"
    ))
    expect_length(unique(res$PROBEID), 100L)
})

test_that("SeqId conversion works as expected when performed in `select()`", {
    # Valid IDs
    x <- c(
        "seq.20553.2", "seq.5452.71", "seq.17784.23", "seq.21752.10",
        "seq.5476.66", "seq.5183-53", "21152-25_9", "seq.11138.16_6"
    )
    # Invalid IDs
    y <- c("seq.1234.56", "seq.5678.90", "seq.1234.56_78", "Test.test.test")

    res <- quiet(select(SomaScan.db, keys = x, columns = "PROBEID")$PROBEID)

    expect_identical(res, c(
        "20553-2", "5452-71", "17784-23", "21752-10",
        "5476-66", "5183-53", "21152-25", "11138-16"
    ))
    expect_error(
        select(SomaScan.db, keys = y, columns = "PROBEID"),
        paste(
            "None of the keys entered are valid keys for 'PROBEID'.",
            "Please use the keys method to see a listing of valid arguments."
        )
    )
})

test_that("SeqId conversion doesn't drop values", {
    # Mix of valid and invalid IDs
    z <- c(
        "seq.20553.2", "seq.5452.71", "seq.17784.23_9", "seq.21752.10",
        "seq.5476.66", "seq.5183-53", "seq.1234.56", "seq.5678.90",
        "seq.1234.56_78", "Test.test.test"
    )
    res <- quiet(select(SomaScan.db, keys = z, columns = "PROBEID"))

    # Invalid IDs are not dropped
    expect_identical(length(z), length(res$PROBEID))
})

test_that("`SomaScan.db` correctly uses SeqIds as primary database keys", {
    expect_type(k, "character")
    expect_length(k, 100L) # No keys should be dropped by `keys`
    expect_true(all(SomaDataIO::is.SeqId(k)))
})

test_that("`keytypes()` works as expected for a SomaDb-class object", {
    expect_type(kt, "character")
    expect_equal(kt, c(
        "ACCNUM", "ALIAS", "ENSEMBL", "ENSEMBLPROT", "ENSEMBLTRANS",
        "ENTREZID", "ENZYME", "EVIDENCE", "EVIDENCEALL", "GENENAME",
        "GENETYPE", "GO", "GOALL", "IPI", "MAP", "OMIM", "ONTOLOGY",
        "ONTOLOGYALL", "PATH", "PFAM", "PMID", "PROBEID", "PROSITE",
        "REFSEQ", "SYMBOL", "UCSCKG", "UNIPROT"
    ))
})

test_that("`columns()` works as expected for a SomaDb class object", {
    cols <- columns(SomaScan.db)
    expect_type(cols, "character")
    expect_identical(cols, kt) # The columns and keytypes should be the same
})

test_that("`select` returns the expected analytes when `menu = v4.0`", {
    expect_s3_class(res_5k, "data.frame")
    expect_named(res_5k, "PROBEID")
    expect_length(res_5k$PROBEID, 4966L)
})

test_that("`select()` returns the expected analytes when `ver = v4.1`", {
    expect_s3_class(res_7k, "data.frame")
    expect_named(res_7k, "PROBEID")
    expect_length(res_7k$PROBEID, 7267L)
})

test_that("`select()` returns the expected analytes by default", {
    expect_identical(res_def, res_7k) # v4.1/7k should be returned by default
    expect_identical(somascan_menu$v4.1, unique(res_def$PROBEID))
})

test_that("`select()` returns the expected analytes when assay version aliases are provided", {
    expect_identical(res_5k, select(SomaScan.db, keys = keys(SomaScan.db), 
                                    columns = "PROBEID", menu = "5k"))
    expect_identical(res_7k, select(SomaScan.db, keys = keys(SomaScan.db), 
                                    columns = "PROBEID", menu = "7k"))
})

test_that("`mapIds()` returns different outputs when `multiVals` is specified", {
    
    res <- lapply(c("first", "list", "filter", "asNA"), function(x) 
      mapIds(SomaScan.db, keys = k[1:5], column = "ALIAS", multiVals = x)
    )
    
    names(res) <- c("first", "list", "filter", "asNA")
    
    expect_type(res$first, "character")
    expect_type(res$list, "list")
    expect_length(res$filter, 0)
    
    na_vec <- rep(NA_character_, 5)
    names(na_vec) <- k[1:5]
    expect_identical(res$asNA, na_vec, 5)
})
