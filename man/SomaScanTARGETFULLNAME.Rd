\name{SomaTARGETFULLNAME}
\alias{SomaScanTARGETFULLNAME}
\title{Map between Manufacturer Identifiers and Full Name of Protein Target}
\description{
  SomaScanTARGETFULLNAME is an R object that provides mappings between
  manufacturer identifiers and the protein names. 
}
\details{
  Each manufacturer identifier is mapped to the full name of the SOMAmer protein
  target. An \code{NA} is reported if there is no target name information for a 
  given SOMAmer and its identifier.
  
  The full protein target name is typically written in sentence case without
  using gene symbol abbreviations, however gene symbols can still occasionally
  be found in some target names. This information can also be found in an ADAT
  file with the accompanying target name (an abbreviated version of the full
  name found in this mapping).
  
  Mappings were based on data provided by: SomaLogic
  https://somalogic.com/somascan-menu/  
  With a date stamp from the source of: 2021-Oct
  
}

\references{
  \url{https://somalogic.com/somascan-menu/}
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
x <- SomaScanTARGETFULLNAME
# Get the probe identifiers that are mapped to a gene symbol
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {
  # Get the TARGETFULLNAME for the first five probes
  xx[1:5]
  # Get the first one
  xx[[1]]
}
}

\keyword{datasets}

