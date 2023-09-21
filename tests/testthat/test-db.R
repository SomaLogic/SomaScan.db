# Setup ------------
library(DBI)

# Retrieval functions
getProbes <- function() {
    require("SomaScan.db")
    as.numeric(dbGetQuery(
        dbconn(SomaScan.db),
        "SELECT count(DISTINCT probe_id) FROM probes"
    ))
}

getGenes <- function() {
    require("SomaScan.db")
    as.numeric(dbGetQuery(
        dbconn(SomaScan.db),
        "SELECT count(DISTINCT gene_id) FROM probes"
    ))
}

# Error messages
probeMsg <- paste("This package has no probes. This can be caused by a large number ",
    "of upstream changes. But it's usually caused by alterations to the source ",
    "files used to extract the probes at the very beginning.",
    sep = ""
)

geneMsg <- paste("This package has no genes. This can be caused by a large number ",
    "of upstream changes. But it's usually caused by alterations to the source ",
    "files used to extract the probes at the very beginning.",
    sep = ""
)


# Testing ----------
test_that("Verify probes and genes exist (for chip packages)", {
    expect_true(getProbes() > 0,
        label = paste(strwrap(probeMsg, exdent = 2), collapse = "\n")
    )

    expect_true(getGenes() > 0,
        label = paste(strwrap(geneMsg, exdent = 2), collapse = "\n")
    )
})
