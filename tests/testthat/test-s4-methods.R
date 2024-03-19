# Setup ------------
k <- withr::with_seed(101, sample(keys(SomaScan.db), 100L, replace = FALSE))
any(duplicated(k))

kt <- keytypes(SomaScan.db)

quiet({
    res_def <- select(SomaScan.db, keys = keys(SomaScan.db), 
                      columns = "PROBEID")
    res_5k <- select(SomaScan.db, keys = keys(SomaScan.db), 
                     columns = "PROBEID", menu = "v4.0")
    res_7k <- select(SomaScan.db, keys = keys(SomaScan.db), 
                     columns = "PROBEID", menu = "v4.1")
    res_11k <- select(SomaScan.db, keys = keys(SomaScan.db), 
                      columns = "PROBEID", menu = "v5.0")
})



# Testing ----------
test_that("`SomaScan.db` correctly uses SeqIds as primary database keys", {
  expect_type(k, "character")
  expect_length(k, 100L) # No keys should be dropped by `keys`
  expect_true(all(SomaDataIO::is.SeqId(k)))
})

test_that("`select()` works as expected for a SomaDb class object", {
    res <- select(SomaScan.db,
                  keys = k,
                  columns = c("ENSEMBL", "UNIPROT"))
    
    expect_s3_class(res, "data.frame")
    # Returns PROBEID column by default
    expect_named(res, c("PROBEID", "ENSEMBL", "UNIPROT"))
    # Exact number of results can vary depending on Bioc release,
    # but all SeqIds should be represented in the output
    expect_length(unique(res$PROBEID), 100L)
})

test_that("`select()` does NOT return PROBEID col when keytype is specified", {
  x <- select(SomaScan.db, keys = "BECN1", 
              keytype = "SYMBOL", columns = "UNIPROT")
  
  # Doesn't return the PROBEID column because the keytype used is non-default
  expect_named(x, c("SYMBOL", "UNIPROT"))
})

test_that("`select()` SeqId conversion works as expected", {
    # Valid IDs
    x <- c("seq.20553.2", "seq.5452.71", "seq.17784.23", "seq.21752.10",
           "seq.5476.66", "seq.5183-53", "21152-25_9", "seq.11138.16_6")
    # Invalid IDs
    y <- c("seq.1234.56", "seq.5678.90", "seq.1234.56_78", "Test.test.test")
    
    res <- select(SomaScan.db, keys = x, columns = "PROBEID")$PROBEID
    
    expect_identical(res, c("20553-2", "5452-71", "17784-23", "21752-10",
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

test_that("`select()` SeqId conversion doesn't drop values", {
    # Mix of valid and invalid IDs
    z <- c("seq.20553.2", "seq.5452.71", "seq.17784.23_9", "seq.21752.10",
           "seq.5476.66", "seq.5183-53", "seq.1234.56", "seq.5678.90",
           "seq.1234.56_78", "Test.test.test")
    res <- select(SomaScan.db, keys = z, columns = "PROBEID")
    
    # Invalid IDs are not dropped
    expect_length(res$PROBEID, length(z))
})

test_that("`select()` produces the expected informative messages", {
    expect_message(
      select(SomaScan.db, keys = "VEGFA", keytype = "SYMBOL", 
                columns = c("PROBEID", "ENTREZID"), menu = "7k"),
      "The 'menu' argument can only be used when 'keytype = 'PROBEID''"
    )
})

test_that("`keytypes()` works as expected for a SomaDb-class object", {
    expect_type(kt, "character")
    expect_equal(kt, c("ACCNUM", "ALIAS", "ENSEMBL", "ENSEMBLPROT", 
                       "ENSEMBLTRANS", "ENTREZID", "ENZYME", "EVIDENCE", 
                       "EVIDENCEALL", "GENENAME", "GENETYPE", "GO", "GOALL", 
                       "IPI", "MAP", "OMIM", "ONTOLOGY", "ONTOLOGYALL", 
                       "PATH", "PFAM", "PMID", "PROBEID", "PROSITE", "REFSEQ", 
                       "SYMBOL", "UCSCKG", "UNIPROT"))
})

test_that("`columns()` works as expected for a SomaDb class object", {
    cols <- columns(SomaScan.db)
    expect_type(cols, "character")
    expect_identical(cols, kt) # The columns and keytypes should be the same
})

test_that("`select()` returns the expected analytes by default", {
  # Superset of the available menu (currently equivalent to 11k) should be 
  # returned when no menu is specified
  expect_identical(res_def, res_11k) 
  expect_identical(somascan_menu$v5.0, unique(res_def$PROBEID))
})

test_that("`select` returns expected number of analytes when menu is specified", {
    expect_s3_class(res_5k, "data.frame")
    expect_named(res_5k, "PROBEID")
    expect_length(res_5k$PROBEID, 4966L)
    
    expect_s3_class(res_7k, "data.frame")
    expect_named(res_7k, "PROBEID")
    expect_length(res_7k$PROBEID, 7267L)
    
    expect_s3_class(res_11k, "data.frame")
    expect_named(res_11k, "PROBEID")
    expect_length(res_11k$PROBEID, 10731L)
})

test_that("`select()` returns expected analytes when version aliases are provided", {
    expect_identical(res_5k, select(SomaScan.db, keys = keys(SomaScan.db), 
                                    columns = "PROBEID", menu = "5k"))
    expect_identical(res_7k, select(SomaScan.db, keys = keys(SomaScan.db), 
                                    columns = "PROBEID", menu = "7k"))
    expect_identical(res_11k, select(SomaScan.db, keys = keys(SomaScan.db), 
                                    columns = "PROBEID", menu = "11k"))
})

test_that("`mapIds()` returns different outputs when `multiVals` is specified", {
    res <- lapply(c("first", "list", "filter", "asNA"), function(x) 
      quiet(
        mapIds(SomaScan.db, keys = k[1:5L], column = "ALIAS", multiVals = x)
      )
    )
    names(res) <- c("first", "list", "filter", "asNA")
    
    expect_type(res$first, "character")
    expect_type(res$list, "list")
    expect_length(res$filter, 0L)
    
    na_vec <- rep(NA_character_, 5L)
    names(na_vec) <- k[1:5L]
    expect_identical(res$asNA, na_vec)
})
