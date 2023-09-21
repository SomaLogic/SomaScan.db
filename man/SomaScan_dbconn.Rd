
\name{SomaScan_dbconn}

\alias{SomaScan_dbconn}
\alias{SomaScan_dbfile}
\alias{SomaScan_dbschema}
\alias{SomaScan_dbInfo}


\title{Collect information about the package annotation DB}

\description{
  Some convenience functions for getting a connection object to (or collecting
  information about) the package annotation DB.
}

\usage{
  SomaScan_dbconn()
  SomaScan_dbfile()
  SomaScan_dbschema(file="", show.indices=FALSE)
  SomaScan_dbInfo()
}

\arguments{
  \item{file}{
    A connection, or a character string naming the file to print to (see
    the \code{file} argument of the \code{\link[base]{cat}} function for
    the details).
  }
  \item{show.indices}{
    The CREATE INDEX statements are not shown by default.
    Use \code{show.indices=TRUE} to get them.
  }
}

\details{
  \code{SomaScan_dbconn} returns a connection object to the
  package annotation DB.  IMPORTANT: Don't call
  \code{\link[DBI:dbConnect]{dbDisconnect}} on the connection object
  returned by \code{SomaScan_dbconn} or you will break all the
  \code{\link[AnnotationDbi:AnnDbObj-class]{AnnDbObj}} objects defined
  in this package!

  \code{SomaScan_dbfile} returns the path (character string) to the
  package annotation DB (this is an SQLite file).

  \code{SomaScan_dbschema} prints the schema definition of the
  package annotation DB.

  \code{SomaScan_dbInfo} prints other information about the package
  annotation DB.
}

\value{
  \code{SomaScan_dbconn}: a DBIConnection object representing an
  open connection to the package annotation DB.

  \code{SomaScan_dbfile}: a character string with the path to the
  package annotation DB.

  \code{SomaScan_dbschema}: none (invisible \code{NULL}).

  \code{SomaScan_dbInfo}: none (invisible \code{NULL}).
}

\seealso{
  \code{\link[DBI:dbSendQuery]{dbGetQuery}},
  \code{\link[DBI:dbConnect]{dbConnect}},
  \code{\link[AnnotationDbi:AnnDbObj-class]{dbconn}},
  \code{\link[AnnotationDbi:AnnDbObj-class]{dbfile}},
  \code{\link[AnnotationDbi:AnnDbObj-class]{dbschema}},
  \code{\link[AnnotationDbi:AnnDbObj-class]{dbInfo}}
}

\examples{
  library(DBI)
  ## Count the number of rows in the "probes" table:
  dbGetQuery(SomaScan_dbconn(), "SELECT COUNT(*) FROM probes")

  SomaScan_dbschema()

  SomaScan_dbInfo()
}

\keyword{utilities}
\keyword{datasets}

