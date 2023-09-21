# Can view addl info about S4 classes using:
# getClass("SomaDb")
# showClass("SomaDb")
# is("SomaDb)

test_that("`SomaScan.db` is a 'SomaDb' class object", {
    expect_s4_class(SomaScan.db, "SomaDb")
})

test_that("The `SomaDb` class has the expected characteristics", {
    expect_true(isClass("SomaDb"))
    expect_true(inherits(SomaScan.db, "SomaDb"))
    expect_true(inherits(SomaScan.db, "ChipDb"))
})
