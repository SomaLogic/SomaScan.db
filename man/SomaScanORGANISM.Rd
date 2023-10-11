\name{SomaScanORGANISM}
\alias{SomaScanORGANISM}
\alias{SomaScanORGPKG}
\title{The Organism information for SomaScan}
\description{
    \code{SomaScanORGANISM} is an R object that contains a single item: a
    character string that names the organism for which SomaScan was
    built.
    \code{SomaScanORGPKG} is an R object that contains a character vector
    with the name of the organism package that a chip package depends on
    for its gene-centric annotations.
}

\details{
    \code{SomaScanORGANISM} provides a simple way to programmatically extract 
    the organism name. \code{SomaScanORGPKG} provides a simple way to 
    programmatically extract the name of the parent organism package. The 
    parent organism package is a strict dependency for chip packages, as this 
    is where the gene-centric information is ultimately extracted from. The 
    full package name will always be this string plus the extension ".db". But
    most programmatic access will not require this extension, so it is more
    convenient to leave it out.
}

\value{
    A \link{Bimap} object of the \code{ProbeAnnDbBimap} class.
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
SomaScanORGANISM
SomaScanORGPKG
}

\keyword{datasets}
