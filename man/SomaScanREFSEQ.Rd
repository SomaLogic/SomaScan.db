\name{SomaScanREFSEQ}
\alias{SomaScanREFSEQ}
\title{Map between SomaScan SeqIds and RefSeq identifiers}
\description{
    \code{SomaScanREFSEQ} is an R object that provides mappings between
    \code{SeqIds} and RefSeq identifiers.
}
\details{
    Each manufacturer identifier is mapped to a named vector of RefSeq 
    identifiers. The name represents the manufacturer identifier, and the 
    vector contains all RefSeq identifiers that can be mapped to that 
    \code{SeqId}. The length of the vector may be one or greater, depending on 
    how many RefSeq identifiers a given \code{SeqId} can be mapped to. An
    \code{NA} is reported for any \code{SeqId} that cannot be mapped to a 
    RefSeq identifier at this time.

    RefSeq identifiers differ in format according to the type of record. See
    the identifier descriptions below, where \code{XXXXX} is a sequence of 
    integers:

    \itemize{
        \item \code{NG_XXXXX}: RefSeq accessions for genomic region 
        (nucleotide) records
        \item \code{NM_XXXXX}: RefSeq accessions for mRNA records
        \item \code{NC_XXXXX}: RefSeq accessions for chromosome records
        \item \code{NP_XXXXX}: RefSeq accessions for protein records
        \item \code{XR_XXXXX}: RefSeq accessions for model RNAs that are not 
        associated with protein products
        \item \code{XM_XXXXX}: RefSeq accessions for model mRNA records
        \item \code{XP_XXXXX}: RefSeq accessions for model protein records
    }

    NCBI (\url{https://www.ncbi.nlm.nih.gov/RefSeq/}) allows users to query
    the RefSeq database using RefSeq identifiers.

    Mappings were based on data provided by Entrez Gene 
    (\url{ftp://ftp.ncbi.nlm.nih.gov/gene/DATA}), 
    with a date stamp from the source of: 2021-Sep13
}

\references{
    \url{https://www.ncbi.nlm.nih.gov}
    \url{https://www.ncbi.nlm.nih.gov/RefSeq/} 
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
x <- SomaScanREFSEQ
# Get the probe identifiers that are mapped to any RefSeq ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {
    # Get the REFSEQ for the first five probes
    xx[1:5]
    # Get the first value
    xx[[1]]
}
}

\keyword{datasets}
