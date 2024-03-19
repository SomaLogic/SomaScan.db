# Setup ------------
# All valid IDs
x <- c("seq.1234.56", "1234-56", "seq.1234-56_78", "seq.1234.56_78")
res <- getSeqId(x)

# Mix of valid and invalid IDs
y <- c("1234-56", "1234_56", "1234.56", "12.3456.78",
       "1234", "abc.DEFGH.12", "ABCDE", "Homo.Sapiens_12",
       "1", NA, NULL)
inv_res <- getSeqId(y)


# Testing ---------
test_that("`getSeqId()` correctly coverts values to SeqIds", {
    expect_true(all(SomaDataIO::is.SeqId(res)))
    expect_identical(getSeqId(x), SomaDataIO::apt2seqid(x))
    expect_equal(res, c("1234-56", "1234-56", "1234-56", "1234-56"))
})

test_that("`getSeqId()` properly handles invalid SeqIds", {
    # Testing vector of "bad" IDs
    expect_equal(length(inv_res), length(y)) # Drop nothing, even invalid IDs
    expect_type(inv_res, "character") # Numerics converted to NA (character)

    # Testing each edge case individually
    expect_equal(getSeqId(NA_character_), NA_character_)
    expect_equal(getSeqId(105), NA_character_)
    expect_equal(getSeqId(NULL), character(0))
})

test_that("`getSeqId()` properly handles old/legacy SeqIds", {
    # Gene name prefix should be trimmed
    t <- mapIds(SomaScan.db, keys = "TEST.10558.26", column = "ENTREZID")
    expect_named(t, "10558-26")
    expect_identical(unname(t), "5101")
})

test_that("`getSeqId()` works as expected when used in a `select()` call", {
    k <- withr::with_seed(101, sample(keys(SomaScan.db), 10))
    sel_res <- suppressMessages(
        select(SomaScan.db,
            keys = k,
            columns = "ENTREZID"
        )
    )
    expect_identical(k, c(
        "34799-31", "20520-14", "9123-18", "21707-15", "29325-43", 
        "29148-63", "34785-16", "21115-48", "3872-2", "30232-17"
    ))
    expect_type(sel_res$PROBEID, "character")
    expect_identical(getSeqId(sel_res$PROBEID), sel_res$PROBEID)
})
