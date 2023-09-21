\name{SomaScanENSEMBL}
\alias{SomaScanENSEMBL}
\alias{SomaScanENSEMBL2PROBE}
\title{Map Ensembl gene accession numbers with Entrez Gene identifiers}  
\description{ 
  SomaScanENSEMBL is an R object that contains mappings between 
  manufacturer identifiers and Ensembl gene accession numbers.    
}
\details{
  This object is a simple mapping of manufacturer identifiers to Ensembl
  gene Accession Numbers.

  Mappings were based on data provided by BOTH of these sources:
  \url{http://www.ensembl.org/biomart/martview/}
  \url{ftp://ftp.ncbi.nlm.nih.gov/gene/DATA}

  For most species, this mapping is a combination of manufacturer to
  ensembl IDs from BOTH NCBI and ensembl.  Users who wish to only use
  mappings from NCBI are encouraged to see the ncbi2ensembl table in the
  appropriate organism package.  Users who wish to only use mappings
  from ensembl are encouraged to see the ensembl2ncbi table which is
  also found in the appropriate organism packages.  These mappings are
  based upon the ensembl table which is contains data from BOTH of these
  sources in an effort to maximize the chances that you will find a
  match.

  For worms and flies however, this mapping is based only on sources
  from ensembl, as these organisms do not have ensembl to entrez gene
  mapping data at NCBI.
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
x <- SomaScanENSEMBL
# Get the entrez gene IDs that are mapped to an Ensembl ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0) {
  # Get the Ensembl gene IDs for the first five genes
  xx[1:5]
  # Get the first one
  xx[[1]]
}
#For the reverse map ENSEMBL2PROBE:
x <- SomaScanENSEMBL2PROBE
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0){
   # Gets the entrez gene IDs for the first five Ensembl IDs
   xx[1:5]
   # Get the first one
   xx[[1]]
}
}
\keyword{datasets}



