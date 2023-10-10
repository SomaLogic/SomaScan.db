\name{SomaScanGENENAME}
\alias{SomaScanGENENAME}
\title{Map between SomaScan SeqIds and gene names}
\description{
    \code{SomaScanGENENAME} is an R object that maps \code{SeqId} to the 
    corresponding gene name.
}
\details{
    Each \code{SeqId} maps to a named vector containing the gene
    name. The vector name corresponds to the \code{SeqId}. If the gene
    name is unknown, the vector will contain an \code{NA}.

    Gene names currently include both the \emph{official} (validated by a
    nomenclature committee) and \emph{preferred} names (interim selected for
    display) for genes. Efforts are being made to differentiate the two
    by adding a name to the vector.

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
x <- SomaScanGENENAME
# Get the probe identifiers that are mapped to a gene name
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {
    # Get the GENENAME for the first five probes
    xx[1:5]
    # Get the first value
    xx[[1]]
}
}

\keyword{datasets}
