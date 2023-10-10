\name{SomaScanENTREZID}
\alias{SomaScanENTREZID}
\alias{SomaScanLOCUSID}
\title{Map between SomaScan SeqIds and Entrez gene identifiers}
\description{
    \code{SomaScanENTREZID} is an R object that provides mappings between
    \code{SeqIds} and Entrez Gene identifiers.
}
\details{
    Each \code{SeqId} is mapped to a vector of Entrez Gene identifiers. An 
    \code{NA} is assigned to those \code{SeqIds} that can not be mapped to an 
    Entrez Gene identifier at this time.

    If a given \code{SeqId} can be mapped to different Entrez Gene
    identifiers from various sources, we attempt to select the common
    identifiers. If a concensus cannot be determined, we select the smallest
    identifier.

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
x <- SomaScanENTREZID
# Get the probe identifiers that are mapped to an ENTREZ Gene ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {
    # Get the ENTREZID for the first five probes
    xx[1:5]
    # Get the first value
    xx[[1]]
}
}

\keyword{datasets}
