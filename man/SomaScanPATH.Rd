\name{SomaScanPATH}
\alias{SomaScanPATH}
\alias{SomaScanPATH2PROBE}
\title{Mappings between probe identifiers and KEGG pathway identifiers}
\description{
  KEGG (Kyoto Encyclopedia of Genes and Genomes) maintains pathway data
  for various organisms.

  SomaScanPATH maps probe identifiers to the identifiers used by
  KEGG for pathways in which the genes represented by the probe
  identifiers are involved

  SomaScanPATH2PROBE is an R object that provides mappings between
  KEGG identifiers and manufacturer identifiers.  
}
\details{
  Each KEGG pathway has a name and identifier. Pathway name for a given pathway
  identifier can be obtained using the KEGG data package that can either be
  built using AnnBuilder or downloaded from Bioconductor
  \url{http://www.bioconductor.org}.

  Graphic presentations of pathways are searchable at
  url http://www.genome.ad.jp/kegg/pathway.html by using pathway identifiers as
  keys.   

  Mappings were based on data provided by: KEGG GENOME  
  ftp://ftp.genome.jp/pub/kegg/genomes  
  With a date stamp from the source of: 2011-Mar15

}

\references{
  \url{http://www.genome.ad.jp/kegg/}
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
x <- SomaScanPATH
# Get the probe identifiers that are mapped to a KEGG pathway ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {
  # Get the PATH for the first five probes
  xx[1:5]
  # Get the first one
  xx[[1]]
}

x <- SomaScanPATH
mapped_probes <- mappedkeys(x)
# Now convert the SomaScanPATH2PROBE object to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0){
    # Get the probe identifiers for the first two pathway identifiers
    xx[1:2]
    # Get the first one
    xx[[1]]
} 
}
\keyword{datasets}

