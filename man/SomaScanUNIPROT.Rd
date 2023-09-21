\name{SomaScanUNIPROT}
\alias{SomaScanUNIPROT}
\alias{SomaScanUNIPROT2PROBE}
\title{Map Uniprot accession numbers with Entrez Gene identifiers}  
\description{ 
  SomaScanUNIPROT is an R object that contains mappings between 
  the manufacturer identifiers and Uniprot accession numbers.    
}
\details{
  This object is a simple mapping of manufacturer identifiers  to Uniprot
  Accessions.

  Mappings were based on data provided by NCBI (link above) with an
  exception for fly, which required retrieving the data from ensembl
  \url{http://www.ensembl.org/biomart/martview/}
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
x <- SomaScanUNIPROT
# Get the entrez gene IDs that are mapped to an Uniprot ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0) {
  # Get the Uniprot IDs for the first five genes
  xx[1:5]
  # Get the first one
  xx[[1]]
}
}
\keyword{datasets}



