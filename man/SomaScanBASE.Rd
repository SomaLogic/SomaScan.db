\name{SomaScan.db}
\alias{SomaScan.db}
\alias{SomaScan}
\title{Bioconductor annotation data package for SomaScan}
\description{
    Welcome to the SomaScan.db annotation package. The purpose of
    this package is to provide detailed annotation information for SomaLogic's
    SomaScan platform. This package is updated biannually.

    Objects in this package are accessed using the \code{select()} interface.
    See this package's vignettes for more details, or reference 
    \code{?AnnotationDbi::select} from the \code{AnnotationDbi} package.
}

\value{
    A platform-centric annotation package.
}

\seealso{
    \code{\link[AnnotationDbi]{AnnotationDb-class}} for use of
    \code{keys()}, \code{columns()} and \code{select()}.
}

\examples{
## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.
columns(SomaScan.db)

## Bimap interface:
# The 'old style' of interacting with these objects is manipulation as 
# bimaps. While this approach is still available we strongly encourage the
# use of select().
ls("package:SomaScan.db")
}

\keyword{datasets}
