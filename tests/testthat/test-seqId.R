# Setup ----
# locateSeqId() and getSeqId() are both tested in this file. These
# tests are modified slightly (with permission) from their source package, 
# SomaDataIO

# Testing ----
test_that("locateSeqId() returns NAs and integers with/without SeqId", {
    rex <- locateSeqId(c("Sample", "seq.1234.5"))
    expect_equal(rex, data.frame(x     = c("Sample", "seq.1234.5"),
                                 start = c(NA_integer_, 5L),
                                 stop  = c(NA_integer_, 10L)))
    expect_equal(locateSeqId(NA_character_),
                 data.frame(x     = NA_character_,
                            start = NA_integer_,
                            stop  = NA_integer_)
    )
})

test_that("locateSeqId() works on aptamer names", {
    rex <- locateSeqId("ABCD.1234.5.5")
    expect_equal(rex, data.frame(x = "ABCD.1234.5.5", start = 6L, stop = 13L))
})

test_that("locateSeqId() works on SeqIds", {
    rex <- locateSeqId("1234-5_5")
    expect_equal(rex, data.frame(x = "1234-5_5", start = 1L, stop = 8L))
})

test_that("locateSeqId() works on funky aptamer names", {
    rex <- locateSeqId("SOMAmer.1.12345.666.13")
    expect_equal(rex, data.frame(x = "SOMAmer.1.12345.666.13",
                                 start = 11L, stop = 22L))
    rex <- locateSeqId("ERVV.1.12531.5.3")
    expect_equal(rex, data.frame(x = "ERVV.1.12531.5.3", 
                                 start = 8L, stop = 16L))
    rex <- locateSeqId("ERVV1.12531.5.3")
    expect_equal(rex, data.frame(x = "ERVV1.12531.5.3", 
                                 start = 7L, stop = 15L))
})

test_that("locateSeqId() works with missing version numbers in SeqIds", {
    # 1 digit
    rex <- locateSeqId("1231-8")
    expect_equal(rex, data.frame(x = "1231-8", start = 1L, stop = 6L))
    # 2 digits
    rex <- locateSeqId("1231-54")
    expect_equal(rex, data.frame(x = "1231-54", start = 1L, stop = 7L))
})

test_that("locateSeqId() works with missing version numbers in Aptamers", {
    # 1 digit
    rex <- locateSeqId("ABCD.1231.8")
    expect_equal(rex, data.frame(x = "ABCD.1231.8", start = 6L, stop = 11L))
    # 2 digits
    rex <- locateSeqId("ABCD.1231.54")
    expect_equal(rex, data.frame(x = "ABCD.1231.54", start = 6L, stop = 12L))
})

test_that("locateSeqId() uses the trailing argument", {
    rex <- locateSeqId("ABCD.1231.54.EFGH", trailing = TRUE)
    expect_equal(rex, data.frame(x = "ABCD.1231.54.EFGH",
                                 start = NA_integer_, stop = NA_integer_))
    rex <- locateSeqId("ABCD.1231.54.EFGH", trailing = FALSE)
    expect_equal(rex, data.frame(x = "ABCD.1231.54.EFGH", 
                                 start = 6L, stop = 12L))
})

test_that("`getSeqId()` deals with AptNames correctly", {
    expect_equal(getSeqId("ABDC.3948.48.2"), "3948-48")
    expect_equal(getSeqId("My.Favorite.Apt.3948.88.9"), "3948-88")
})

test_that("`getSeqId()` deals with SeqIds of various sorts", {
    expect_equal(getSeqId("3948.48.2"), "3948-48")
    expect_equal(getSeqId("3948-48_2"), "3948-48")
    expect_equal(getSeqId("3948-48"), "3948-48")
    expect_equal(getSeqId("3948.48"), "3948-48")
})

test_that("`getSeqId()` vectorization works", {
    seq_vec <- getSeqId(c("seq.1234.56_5", "ABDC.3948.48_2", "9876.54.3"))
    expect_equal(seq_vec, c("1234-56", "3948-48", "9876-54"))
})

test_that("`getSeqId()` returns NAs for non-matches; char(0) for NULL", {
    expect_equal(getSeqId(""), NA_character_)
    expect_equal(getSeqId("A"), NA_character_)
    expect_equal(getSeqId(NA_character_), NA_character_)
    expect_equal(getSeqId(NULL), character(0))
})

test_that("`getSeqId()` matches only at the end of a string", {
    expect_equal(getSeqId("seq.1234.56_"), NA_character_)
    expect_equal(getSeqId("seq.1234.56x"), NA_character_)
    expect_equal(getSeqId("1234-56x"), NA_character_)
    expect_equal(getSeqId("seq.1234.56 "), "1234-56")   # whitespace trim
    expect_equal(getSeqId("seq.1234.56\t"), "1234-56")  # whitespace trim
    expect_equal(getSeqId("seq.1234.56 A"), NA_character_)
})

test_that("`getSeqId()` type conversion for factors and lists", {
    expect_equal(getSeqId(list("foo", "seq.1234.5")), c(NA_character_, "1234-5"))
    expect_equal(getSeqId(factor("seq.1234.5")), "1234-5")
    expect_equal(getSeqId(factor("foo")), NA_character_)
    # trimws() converts -> "NULL"
    expect_equal(getSeqId(list(NULL)), NA_character_)  
})

test_that("`getSeqId()` properly strips prefix & version number of a SeqId", {
    test_vec <- c("seq.2182-54_1", "seq.2190-55_1", "seq.2192-63_10",
                  "seq.2201-17_6", "seq.2211-9_6", "seq.2212-69_1")
    expect_equal(getSeqId(test_vec),
                 c("2182-54", "2190-55", "2192-63",
                   "2201-17", "2211-9", "2212-69"))
})

test_that("`getSeqId()` properly does nothing when there's no ver number", {
    with_vers <- c("seq.2182-54_1", "seq.2190-55_1", "seq.2192-63_10",
                   "seq.2201-17_6", "seq.2211-9_6", "seq.2212-69_1")
    no_vers <- c("seq.2182-54", "seq.2190-55", "seq.2192-63",
                 "seq.2201-17", "seq.2211-9", "seq.2212-69")
    expect_equal(getSeqId(with_vers),
                 getSeqId(no_vers))
})
