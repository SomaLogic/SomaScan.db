\name{SomaScanENZYME}
\alias{SomaScanENZYME}
\alias{SomaScanENZYME2PROBE}
\title{Maps between Manufacturer IDs and Enzyme Commission (EC) Numbers}
\description{ 
  SomaScanENZYME is an R object that provides mappings between
  manufacturer identifiers and EC numbers.
  SomaScanENZYME2PROBE is an R object that maps Enzyme Commission
  (EC) numbers to manufacturer identifiers.
}
\details{
  When the SomaScanENZYME maping viewed as a list, each
  manufacturer identifier maps to a named vector containing the EC
  number that corresponds to the enzyme produced by that gene. The names
  corresponds to the manufacturer identifiers. If this information is
  unknown, the vector will contain an \code{NA}.

  For the SomaScanENZYME2PROBE, each EC number maps to a named
  vector containing all of the manufacturer identifiers that correspond
  to the gene that produces that enzyme. The name of the vector
  corresponds to the EC number.
  
  Enzyme Commission numbers are assigned by the Nomenclature Committee
  of the International Union of Biochemistry and Molecular Biology
  \url{http://www.chem.qmw.ac.uk/iubmb/enzyme/} to allow enzymes to be
  identified. 
  
  An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z,
  and w are numeric numbers. In SomaScanENZYME2PROBE, EC is dropped from the
  Enzyme Commission numbers.

  Enzyme Commission numbers have corresponding names that describe the
  functions of enzymes in such a way that EC x is a more general
  description than EC x.y that in turn is a more general description than
  EC x.y.z. The top level EC numbers and names are listed below:

  EC 1 oxidoreductases
  
  EC 2 transferases

  EC 3 hydrolases

  EC 4 lyases
  
  EC 5 isomerases
  
  EC 6 ligases
  
  The EC name for a given EC number can be viewed at
  \url{http://www.chem.qmul.ac.uk/iupac/jcbn/index.html#6} 
  
  Mappings between probe identifiers and enzyme identifiers were obtained using files
  provided by: KEGG GENOME  
  ftp://ftp.genome.jp/pub/kegg/genomes  
  With a date stamp from the source of: 2011-Mar15

}

\references{
\url{ftp://ftp.genome.ad.jp/pub/kegg/pathways}
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
x <- SomaScanENZYME
# Get the probe identifiers that are mapped to an EC number 
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:3])
if(length(xx) > 0) {
  # Get the ENZYME for the first five probes
  xx[1:5]
  # Get the first one
  xx[[1]]
}

# Now convert SomaScanENZYME2PROBE to a list to see inside
x <- SomaScanENZYME2PROBE
mapped_probes <- mappedkeys(x)
## convert to a list
xx <- as.list(x[mapped_probes][1:3])
if(length(xx) > 0){
   # Get the probe identifiers for the first five enzyme
   #commission numbers
   xx[1:5]
   # Get the first one
   xx[[1]]
}
}
\keyword{datasets}

