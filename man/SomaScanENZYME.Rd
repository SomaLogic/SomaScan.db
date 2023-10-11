\name{SomaScanENZYME}
\alias{SomaScanENZYME}
\alias{SomaScanENZYME2PROBE}
\title{Map between SomaScan SeqIds and Enzyme Commission (EC) numbers}
\description{ 
    \code{SomaScanENZYME} is an R object that provides mappings between
    \code{SeqIds} and EC numbers. \code{SomaScanENZYME2PROBE} is an R object 
    that maps Enzyme Commission (EC) numbers to \code{SeqIds}.
}

\details{
    When the \code{SomaScanENZYME} mapping viewed as a list, each
    manufacturer identifier maps to a named vector containing the EC
    number that corresponds to the enzyme produced by that gene. The names
    correspond to the \code{SeqIds}. If this information is unknown, the 
    vector will contain an \code{NA}.

    For the \code{SomaScanENZYME2PROBE} object, each EC number maps to a named
    vector containing all of the \code{SeqIds} that correspond
    to the gene that produces that enzyme. The name of the vector
    corresponds to the EC number.

    EC numbers are assigned by the Nomenclature Committee
    of the International Union of Biochemistry and Molecular Biology
    (\url{http://www.chem.qmw.ac.uk/iubmb/enzyme/}) to allow enzymes to be
    identified. 

    An EC number is of the format \code{EC x.y.z.w}, 
    where \code{x}, \code{y}, \code{z}, and \code{w} are numeric values. 
    In \code{SomaScanENZYME2PROBE}, the "EC" prefix is dropped from the Enzyme
    Commission numbers.

    EC numbers have corresponding names that describe the
    functions of enzymes in such a way that \code{EC x} is a more general
    description than \code{EC x.y}, that in turn is a more general description 
    than \code{EC x.y.z}. The top level EC numbers and names are listed below:

    \itemize{
      \item EC 1 oxidoreductases
      \item EC 2 transferases
      \item EC 3 hydrolases
      \item EC 4 lyases
      \item EC 5 isomerases
      \item EC 6 ligases
    }

    The EC name for a given EC number can be viewed at
    \url{http://www.chem.qmul.ac.uk/iupac/jcbn/index.html#6} 

    Mappings between \code{SeqIds} and enzyme identifiers were obtained 
    using files provided by KEGG GENOME 
    (\url{ftp://ftp.genome.jp/pub/kegg/genomes}), 
    with a date stamp from the source of: 2011-Mar15
}

\value{
    A \link{Bimap} object of the \code{ProbeAnnDbBimap} class.
}

\references{
\url{ftp://ftp.genome.ad.jp/pub/kegg/pathways}
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
    # Get the first value
    xx[[1]]
}
}

\keyword{datasets}
