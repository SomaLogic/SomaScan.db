\name{SomaScanUNIPROT}
\alias{SomaScanUNIPROT}
\alias{SomaScanUNIPROT2PROBE}
\title{Map between Uniprot accession numbers and SomaScan SeqIds}
\description{ 
    \code{SomaScanUNIPROT} is an R object that contains mappings between 
    \code{SeqIds} and Uniprot accession numbers.
}

\details{
    This object is a simple mapping of \code{SeqIds} to Uniprot
    accession numbers.

    Human mappings were based on data provided by NCBI, with an
    exception for fly, which required retrieving the data from Ensembl
    (\url{http://www.ensembl.org/biomart/martview/}).
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
x <- SomaScanUNIPROT
# Get the entrez gene IDs that are mapped to an Uniprot ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0) {
    # Get the Uniprot IDs for the first five genes
    xx[1:5]
    # Get the first value
    xx[[1]]
}
}
\keyword{datasets}
