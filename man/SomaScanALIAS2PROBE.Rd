\name{SomaScanALIAS2PROBE}
\alias{SomaScanALIAS2PROBE}
\title{Map between Common Gene Symbol Identifiers and Manufacturer Identifiers}
\description{
  SomaScanALIAS is an R object that provides mappings between
  common gene symbol identifiers and manufacturer identifiers.
}
\details{
  Each gene symbol is mapped to a named vector of manufacturer identifiers. The
  name represents the gene symbol and the vector contains all manufacturer
  identifiers that are found for that symbol. An \code{NA} is reported for any
  gene symbol that cannot be mapped to any manufacturer identifiers.

  This mapping includes ALL gene symbols including those which are already
  listed in the SYMBOL map.  The SYMBOL map is meant to only list official gene
  symbols, while the ALIAS maps are meant to store all used symbols.

  Mappings were based on data provided by: Entrez Gene  
  ftp://ftp.ncbi.nlm.nih.gov/gene/DATA  
  With a date stamp from the source of: 2021-Sep13
}

\seealso{
  \itemize{
    \item \code{\link[AnnotationDbi]{AnnotationDb-class}} for use of
          the \code{select()} interface.
  }
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
    # Get the first one
    xx[[1]]
}
}

\keyword{datasets}
