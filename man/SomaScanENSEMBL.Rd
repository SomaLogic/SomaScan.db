\name{SomaScanENSEMBL}
\alias{SomaScanENSEMBL}
\alias{SomaScanENSEMBL2PROBE}
\title{Map Ensembl gene accession numbers with Entrez Gene identifiers}
\description{
    \code{SomaScanENSEMBL} is an R object that contains mappings between 
    \code{SeqIds} and Ensembl gene accession numbers.
}

\details{
    This object is a simple mapping of \code{SeqIds} to Ensembl
    gene accession numbers.

    For most species, this mapping is a combination of \code{SeqIds} to
    Ensembl IDs from \emph{both} NCBI and Ensembl. Users who wish to only use
    mappings from NCBI are encouraged to see the \code{ncbi2ensembl} table in 
    the appropriate organism package. Users who wish to only use mappings
    from Ensembl are encouraged to see the \code{ensembl2ncbi} table which, 
    like \code{ncbi2ensembl}, is found in the appropriate organism package. 
    These mappings are based upon the Ensembl table, which contains data from 
    both of these sources in an effort to maximize the chances of finding
    a match.

    Mappings were based on data provided by both of these sources:
    \itemize{
      \item \url{http://www.ensembl.org/biomart/martview/}
      \item \url{ftp://ftp.ncbi.nlm.nih.gov/gene/DATA}
    }
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
x <- SomaScanENSEMBL
# Get the entrez gene IDs that are mapped to an Ensembl ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0) {
    # Get the Ensembl gene IDs for the first five genes
    xx[1:5]
    # Get the first value
    xx[[1]]
}

# For the reverse map ENSEMBL2PROBE:
x <- SomaScanENSEMBL2PROBE
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0){
    # Gets the entrez gene IDs for the first five Ensembl IDs
    xx[1:5]
    # Get the first value
    xx[[1]]
}
}

\keyword{datasets}
