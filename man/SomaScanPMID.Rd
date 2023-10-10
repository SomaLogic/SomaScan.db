\name{SomaScanPMID}
\alias{SomaScanPMID}
\alias{SomaScanPMID2PROBE}
\title{Maps between SomaScan SeqIds and PubMed identifiers}
\description{
    \code{SomaScanPMID} is an R object that provides mappings between
    \code{SeqIds} and PubMed identifiers.
    
    \code{SomaScanPMID2PROBE} is an R object that provides mappings between
    PubMed identifiers and \code{SeqIDs}.
}

\details{
    When \code{SomaScanPMID} is viewed as a list, each \code{SeqId} is mapped 
    to a named vector of PubMed identifiers. The name associated with each 
    vector corresponds to the \code{SeqId}. The length of the vector may be 
    one or greater, depending on how many PubMed identifiers a given
    \code{SeqId} is mapped to. An \code{NA} is reported for any \code{SeqId}
    that cannot be mapped to a PubMed identifier.

    When \code{SomaScanPMID2PROBE} is viewed as a list, each PubMed
    identifier is mapped to a named vector of \code{SeqIds}. The name 
    represents the PubMed identifier and the vector contains all \code{SeqIds} 
    that are represented by that PubMed identifier. The length of the vector
    may be one or longer, depending on how many \code{SeqIds} are 
    mapped to a given PubMed identifier.

    Titles, abstracts, and possibly full texts of articles can be obtained
    from PubMed by providing a valid PubMed identifier. The \code{pubmed()} 
    function of the \code{annotate} package can also be used for the same 
    purpose.

    Mappings were based on data provided by Entrez Gene 
    (ftp://ftp.ncbi.nlm.nih.gov/gene/DATA), 
    with a date stamp from the source of: 2021-Sep13

}

\references{
    \url{https://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=PubMed}
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
x <- SomaScanPMID
# Get the probe identifiers that are mapped to any PubMed ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0){
    # Get the PubMed identifiers for the first two probe identifiers
    xx[1:2]
    # Get the first one
    xx[[1]]
    if(interactive() && !is.null(xx[[1]]) && !is.na(xx[[1]]) 
    && require(annotate)){
        # Get article information as XML files
        xmls <- pubmed(xx[[1]], disp = "data")
        # View article information using a browser
        pubmed(xx[[1]], disp = "browser")
    }
}

x <- SomaScanPMID2PROBE
mapped_probes <- mappedkeys(x)
# Now convert the reverse map object SomaScanPMID2PROBE to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0){
    # Get the probe identifiers for the first two PubMed identifiers
    xx[1:2]
    # Get the first one
    xx[[1]]
    if(interactive() && require(annotate)){
        # Get article information as XML files for a PubMed id
        xmls <- pubmed(names(xx)[1], disp = "data")
        # View article information using a browser
        pubmed(names(xx)[1], disp = "browser")
    }
}
}

\keyword{datasets}
