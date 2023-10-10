\name{SomaScanSYMBOL}
\alias{SomaScanSYMBOL}
\title{Map between SomaScan SeqIds and Gene Symbols}
\description{
    \code{SomaScanSYMBOL} is an R object that provides mappings between
    \code{SeqIds} and gene abbreviations.
}
\details{
    Each \code{SeqId} is mapped to an abbreviation (symbol) for the
    corresponding gene. An \code{NA} is reported if there is no known
    abbreviation for a given gene.

    Symbols typically consist of 3-6 letters that define either a single
    gene (ABC) or multiple genes (ABC1, ABC2, ABC3). Gene symbols can be
    used as key words to query public databases such as Entrez Gene.

    Mappings were based on data provided by Entrez Gene  
    (ftp://ftp.ncbi.nlm.nih.gov/gene/DATA),  
    with a date stamp from the source of: 2021-Sep13
}

\references{
    \url{https://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene}
}

\seealso{
    \code{\link[AnnotationDbi]{AnnotationDb-class}} for use of
    the \code{select()} interface.
}

\examples{
## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- SomaScanSYMBOL
# Get the probe identifiers that are mapped to a gene symbol
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {
    # Get the SYMBOL for the first five probes
    xx[1:5]
    # Get the first value
    xx[[1]]
}
}

\keyword{datasets}
