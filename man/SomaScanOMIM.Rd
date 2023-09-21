\name{SomaScanOMIM}
\alias{SomaScanOMIM}
\title{Map between Manufacturer Identifiers and Mendelian Inheritance in
  Man (MIM) identifiers}
\description{
  SomaScanOMIM is an R object that provides mappings between
  manufacturer identifiers and OMIM identifiers.
}
\details{
  Each manufacturer identifier is mapped to a vector of OMIM identifiers. The
  vector length may be one or longer, depending on how many OMIM identifiers
  the manufacturer identifier maps to. An \code{NA} is reported for any
  manufacturer identifier that cannot be mapped to an OMIM identifier at this
  time.
  
  OMIM is based upon the book Mendelian Inheritance in Man (V. A. McKusick) and
  focuses primarily on inherited or heritable genetic diseases. It contains
  textual information, pictures, and reference information that can be searched
  using various terms, among which the MIM number is one. 
  
  Mappings were based on data provided by: Entrez Gene  
  ftp://ftp.ncbi.nlm.nih.gov/gene/DATA  
  With a date stamp from the source of: 2021-Sep13
}

\references{
  \url{https://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene}
  \url{https://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=OMIM}
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
x <- SomaScanOMIM
# Get the probe identifiers that are mapped to a OMIM ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {
  # Get the OMIM for the first five probes
  xx[1:5]
  # Get the first one
  xx[[1]]
}
}

\keyword{datasets}

