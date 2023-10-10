\name{SomaScanALIAS2PROBE}
\alias{SomaScanALIAS2PROBE}
\title{Map between Common Gene Symbol Identifiers and SomaScan SeqIds}
\description{
    \code{SomaScanALIAS2PROBE} is an R object that provides mappings between
    common gene symbol identifiers and manufacturer identifiers, i.e. the 
    SomaScan \code{SeqId}.
}

\details{
    Each gene symbol is mapped to a named vector of \code{SeqIds}. 
    The name of each vector element represents the gene symbol, and the vector 
    contains all manufacturer identifiers that are found for that symbol. An 
    \code{NA} is reported for any gene symbol that cannot be mapped to a 
    \code{SeqId}.

    This mapping includes \bold{all} gene symbols, including those which are 
    already listed in the \code{SomaScanSYMBOL} map. The \code{SomaScanSYMBOL} 
    map is meant to only list \emph{official} gene symbols, while the 
    \code{SomaScanALIAS} maps are meant to store all \emph{used} symbols.

    Mappings were based on data provided by Entrez Gene  
    (ftp://ftp.ncbi.nlm.nih.gov/gene/DATA),  
    with a date stamp from the source of: 2021-Sep13
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
# Convert the object to a list
xx <- as.list(SomaScanALIAS2PROBE)
if(length(xx) > 0){
    # Get the probe identifiers for the first two aliases
    xx[1:2]
    # Get the first value
    xx[[1]]
}
}

\keyword{datasets}
