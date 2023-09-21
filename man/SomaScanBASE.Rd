\name{SomaScan.db}
\alias{SomaScan.db}
\alias{SomaScan}
\title{Bioconductor annotation data package}
\description{
  
  Welcome to the SomaScan.db annotation Package.  The purpose of
  this package is to provide detailed information about the
  SomaScan platform. This package is updated biannually.

  Objects in this package are accessed using the \code{select()} interface.
  See ?select in the AnnotationDbi package for details.
}

\seealso{
  \itemize{
    \item \code{\link[AnnotationDbi]{AnnotationDb-class}} for use of
          \code{keys()}, \code{columns()} and \code{select()}.
  }
}

\examples{
## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.
columns(SomaScan.db)

## Bimap interface:
## The 'old style' of interacting with these objects is manipulation as 
## bimaps. While this approach is still available we strongly encourage the
## use of select().
ls("package:SomaScan.db")
}

\keyword{datasets}

