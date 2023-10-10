\name{SomaScanMAP}
\alias{SomaScanMAP}
\title{Map between SomaScan SeqIds and cytogenetic maps/bands}
\description{
    \code{SomaScanMAP} is an R object that provides mappings between
    \code{SeqIds} and cytoband locations.
}

\details{
    Each \code{SeqId} is mapped to a vector of cytoband locations. The
    vector length may be one or longer, if there are multiple reported
    chromosomal locations for a given gene. An \code{NA} is reported for
    any \code{SeqId} that cannot be mapped to a cytoband at this time.

    Cytogenetic bands for most higher organisms are labeled p1, p2, p3,
    q1, q2, q3 (p and q are the p and q arms), etc., counting from the
    centromere out toward the telomeres. At higher resolutions, sub-bands
    can be seen within the bands. The sub-bands are also numbered from the
    centromere out toward the telomere. Thus, a label of 7q31.2 indicates
    that the band is on chromosome 7, q arm, band 3, sub-band 1, and
    sub-sub-band 2.

    Mappings were based on data provided by Entrez Gene 
    (ftp://ftp.ncbi.nlm.nih.gov/gene/DATA),
    with a date stamp from the source of: 2021-Sep13
}

\references{
    \url{https://www.ncbi.nlm.nih.gov}
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
x <- SomaScanMAP
# Get the probe identifiers that are mapped to any cytoband
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {
    # Get the MAP for the first five probes
    xx[1:5]
    # Get the first value
    xx[[1]]
}
}

\keyword{datasets}
