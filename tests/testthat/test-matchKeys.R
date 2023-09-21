# Setup ------------
syms <- mappedRkeys(SomaScanSYMBOL)


# Testing ----------
test_that(".matchKeys() works as expected when a character string is used", {
    k <- .matchKeys("NOTCH") # Default type is SYMBOL
    g <- grep("^NOTCH", syms, value = TRUE) # .matchKeys() adds a `^`
                                            # prefix to the string
    expect_identical(k, g)
})

test_that(".matchKeys() works as expected when a regex pattern is used", {
    k <- .matchKeys("IL2|NO")
    g <- grep("^IL2|NO", syms, value = TRUE)
    
    expect_identical(k, g)
})

test_that(".matchKeys(... type) argument works as expected", {
    k <- .matchKeys("CASC4", type = "ALIAS")
    expect_identical(k, "CASC4")
})

test_that("the `select(..., match = TRUE)` argument works as expected", {
    a <- select(SomaScan.db, keys = "SMAD", 
                columns = "PROBEID", 
                keytype = "ALIAS", match = TRUE)
    s <- select(SomaScan.db, keys = "SMAD", 
                columns = "PROBEID", 
                keytype = "SYMBOL", match = TRUE)
    
    expect_identical(a, data.frame(ALIAS = c("SMAD3", rep("SMAD2", 2), 
                                             "SMAD4", "SMAD4IP1", 
                                             rep("SMAD1", 2), "SMAD5"),
                                  PROBEID = c("10363-13", "10364-6", "11353-143", 
                                             "12022-12", "14008-22", "21351-8", 
                                             "9838-4", "21478-20"))
    )
    
    expect_identical(s, data.frame(SYMBOL = c("SMAD3", rep("SMAD2", 2), 
                                              "SMAD4", "SMAD5", "SMAD1"),
                                  PROBEID = c("10363-13", "10364-6", "11353-143", 
                                              "12022-12", "21478-20", "9838-4"))
  )
})

test_that("the `mapIds(..., match = TRUE)` argument works as expected", {
    a <- mapIds(SomaScan.db, keys = "SMAD", 
                column = "PROBEID", 
                keytype = "ALIAS", match = TRUE)
    
    s <- mapIds(SomaScan.db, keys = "SMAD", 
                column = "PROBEID", 
                keytype = "SYMBOL", match = TRUE)
    
    expect_length(a, 6L)
    expect_length(s, 5L)
    
    expect_identical(a, c(SMAD3    = "10363-13", 
                          SMAD2    = "10364-6" , 
                          SMAD4    = "12022-12",
                          SMAD4IP1 = "14008-22",
                          SMAD1    = "21351-8",
                          SMAD5    = "21478-20")
    )
    
    expect_identical(s, c(SMAD3 = "10363-13", 
                          SMAD2 = "10364-6" , 
                          SMAD4 = "12022-12",
                          SMAD5 = "21478-20", 
                          SMAD1 = "9838-4")
    )
})

test_that("the `select(..., match = TRUE)` argument prints message when no matches found", {
    expect_message(
      select(SomaScan.db, keys = "ZBNC", 
            columns = c("SYMBOL", "PROBEID"), 
            keytype = "SYMBOL", match = TRUE),
      "No 'SYMBOL' matches found for 'ZBNC'!"
    )
})

test_that("the `mapIds(..., match = TRUE)` argument prints message when no matches found", {
    expect_message(
      select(SomaScan.db, keys = "ZBNC", 
                          columns = c("SYMBOL", "PROBEID"), 
                          keytype = "SYMBOL", match = TRUE),
                  "No 'SYMBOL' matches found for 'ZBNC'!"
    )
})
