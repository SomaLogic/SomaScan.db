#' The `keys` method for SomaDb objects
#' 
#' @description `keys` returns the full set of keys for the annotation 
#' database. A database "key" is a unique value that identifies a single row 
#' of the database. By default, `keys` will return a vector of all primary 
#' database keys. The primary keys for `SomaScan.db` are the SomaLogic 
#' sequence identifiers, also called `SeqIds`.
#' 
#' If the `keytype` argument is specified, `keys` will return the keys that are
#' available for that keytype, rather than the `SeqIds` (see examples).
#' 
#' @aliases keys
#' @importFrom AnnotationDbi keys
#' @inherit AnnotationDbi::keys params
#' @returns A character vector of all available database keys.
#' @author Amanda Hiser
#' @examples 
#' # Preview the primary database keys
#' keys(SomaScan.db) |> head()
#' 
#' # View a different type of database key, e.g. gene symbols
#' keys(SomaScan.db, keytype = "SYMBOL") |> head()
#' @exportMethod
setMethod("keys", "SomaDb",
    function(x, keytype, ...) {
        if ( missing(keytype) ) keytype <- "PROBEID"
        x <- as(x, "ChipDb") # Convert back to ChipDb for internal methods
        callNextMethod()
    }
)


#' The `keytypes` method for SomaDb objects
#' 
#' @description `keytypes` produces a vector of annotation categories that can 
#' be used as input keys for the `keytype=` argument of the `select`, `mapIds`,
#' and `keys` methods. The keytype also informs the query of the format of the 
#' search key. For example, when searching the database for annotations 
#' corresponding to the gene "NOTCH3", the key "NOTCH3" has the keytype of 
#' "SYMBOL". Specifying `keytype="SYMBOL"` ensures that the gene symbol is not 
#' confused for a different identifier ("key") type. 
#' 
#' The default keytype ("PROBEID"), corresponds to the SomaLogic `SeqId`. For 
#' more information on database keys, see `?keys`.
#' 
#' @aliases keytypes
#' @importFrom AnnotationDbi keytypes
#' @inherit AnnotationDbi::keytypes params
#' @returns A character vector of all available database keytypes.
#' @author Amanda Hiser
#' @examples 
#' # Retrieve a full list of available keytypes
#' keytypes(SomaScan.db)
#' 
#' # Specify a keytype other than PROBEID for select
#' select(SomaScan.db, keys = "NOTCH3", keytype = "SYMBOL",
#'        columns = "PROBEID")
#' @exportMethod
setMethod("keytypes", "SomaDb",
    function(x) {
        keytypes <- callNextMethod()
        # Adding the PROBEID manually (this is already done
        # internally for ChipDb classes)
        sort(c(keytypes, "PROBEID")) 
    } 
)

#' The `columns` method for `SomaDb` objects
#' 
#' @aliases columns
#' @importFrom AnnotationDbi columns
#' @returns A character vector of all available database columns.
#' @author Amanda Hiser
#' @examples
#' # Retrieve all database columns
#' columns(SomaScan.db)
AnnotationDbi::columns


#' The `select` method for `SomaDb` objects
#' 
#' `select` is the primary data retrieval method for the `SomaScan.db` 
#' database. `select` will retrieve a data frame of SomaScan annotations based 
#' on the parameters provided by the `keys`, `columns`, and `keytype` 
#' arguments. The default keytype is "PROBEID", e.g. the SomaLogic `SeqId`;
#' this value is used to tie all annotations back to a SomaScan-specific 
#' identifier.
#' 
#' Users should be aware that if they call `select` and request columns that 
#' have multiple matches for the provided keys (e.g. GO terms), 
#' `select` will return a `data.frame` with one row _for each possible match_. 
#' This can have a multiplicative effect and result in a large number of 
#' returned values. In general, if a user needs to retrieve a column that has 
#' a many-to-one relationship to the original keys, it is best to extract data 
#' from that column in its own query.
#' @aliases select
#' @importFrom AnnotationDbi select
#' @inherit AnnotationDbi::select params
#' @inheritDotParams AnnotationDbi::select
#' @param menu a character string identifying a SomaScan menu
#'    version (optional). Possible options include: `"5k"`,`"7k"`, or `"11k"`, 
#'    as well as the version numbers for those menus (`"v4.0"`, `"v4.1"`, or 
#'    `"v5.0"`, respectively). May only be used when `keytype = "PROBEID"`. 
#'    This argument will filter the keys to the specified menu and only return 
#'    data associated with analytes present in that menu. By default, all 
#'    annotations from all analytes are available.
#' @param match a logical (TRUE/FALSE). Must be used with the "SYMBOL", 
#'    "ALIAS", or "GENENAME" keytypes only. If true, the character string 
#'    provided for `keys` will be used as a search term. The string will be 
#'    used to match symbols that also start with that string (ex. a key of 
#'    "CASP1" will return annotations for both the CASP10 & CASP14 genes).
#' @returns A `data.frame` containing the retrieved annotations.
#' @author Amanda Hiser
#' @examples 
#' # Retrieve a set of example keys
#' keys <- head(keys(SomaScan.db))
#' keys
#' 
#' # Look up the gene symbol and gene type for all example keys
#' select(SomaScan.db, keys = keys, columns = c("SYMBOL", "GENETYPE"))
#' 
#' # Look up SomaScan SeqIds & proteins associated with a gene of interest
#' select(SomaScan.db, keys = "NOTCH3", keytype = "SYMBOL", 
#'       columns = c("PROBEID", "UNIPROT"))
#' @exportMethod
setMethod("select", "SomaDb",
    function(x, keys, columns, keytype, menu = NULL, match = FALSE, ...) {
        if ( missing(keytype) ) keytype <- "PROBEID"
        if ( !is.null(menu) && keytype != "PROBEID") {
            message("The 'menu' argument can only be used when ", 
                    "'keytype = 'PROBEID''. The results of this query will ",
                    "contain all analytes from the 11k menu.")
        }
        keys <- .preprocessKeys(keytype = keytype, keys = keys, 
                                menu = menu, match = match)
        x <- as(x, "ChipDb") # Convert back to ChipDb for internal methods
        callNextMethod(x, keys, columns, keytype, ...)
    }
)

#' The `mapIds` method for `SomaDb` objects
#' 
#' `mapIds` will retrieve SomaScan annotations (as a named vector) based on 
#' the parameters provided by the `keys`, `columns`, and `keytype` arguments. 
#' The default keytype is "PROBEID", e.g. the SomaLogic `SeqId`; this value 
#' will be used to tie all annotations back to a SomaScan-specific identifier. 
#' 
#' `mapIds` is similar to `select` in that it can be used to retrieve 
#' annotation information from the database. However, users should be aware
#' that if they call `mapIds` and request columns that have multiple matches
#' for the specified keys (ex. GO or other pathway-related terms), `mapIds`
#' will return a named character vector with (by default) _only one_ result 
#' for each possible match. This result in some results being truncated. Make 
#' sure to specify the appropriate `multiVals` parameter for each query.
#' @aliases mapIds
#' @importFrom AnnotationDbi mapIds
#' @inherit AnnotationDbi::mapIds params
#' @inheritParams select,SomaDb-method
#' @inheritDotParams AnnotationDbi::mapIds
#' @returns A named character vector containing the retrieved annotations. 
#'    Missing values will be returned as `NA`.
#' @author Amanda Hiser
#' @examples 
#' # Retrieve a set of example keys
#' keys <- head(keys(SomaScan.db))
#' keys
#' 
#' # Only 1 result is returned by default; missing values are returned as `NA`
#' mapIds(SomaScan.db, keys = keys, column = "UNIPROT")
#' 
#' # Specify `multiVals` to return all results as a list
#' mapIds(SomaScan.db, keys = keys, column = "UNIPROT", multiVals = "list")
#' @exportMethod
setMethod("mapIds", "SomaDb",
          function(x, keys, column, keytype, menu = NULL, match = FALSE, ..., 
                   multiVals = c("filter", "asNA", "first", 
                                 "list", "CharacterList")) {
            if ( missing(keytype) ) keytype <- "PROBEID" 
            if ( !is.null(menu) && keytype != "PROBEID") {
              message("The 'menu' argument can only be used when ", 
                      "'keytype = 'PROBEID''. The results of this query will ",
                      "contain all analytes from the 11k menu.")
            }
            keys <- .preprocessKeys(keytype = keytype, keys = keys, 
                                    menu = menu, match = match)
            x <- as(x, "ChipDb") # Convert back to ChipDb for internal methods
            callNextMethod(x, keys, column, keytype, menu, match, ..., 
                           multiVals = multiVals)
          }
)



########## Internal/hidden functions for the above methods #################

# Performs the SeqId conversion & matching steps used in both
# `select` and `mapIds`
.preprocessKeys <- function(keytype, keys, menu, match) {
    if ( isTRUE(keytype == "PROBEID") ) {
        keys <- .filterSeqIds(keys, menu)
        ids <- getSeqId(keys)
    } else if ( grepl("SYMBOL|ALIAS|NAME", keytype) && isTRUE(match) ) {
        ids <- .matchKeys(keys, keytype)
        if ( length(ids) == 0L ) {
          message(sprintf("No '%s' matches found for '%s'!", keytype, keys))
        }
    } else {
        ids <- keys
    }
    ids
}

# Uses global analyte lists to filter keys (analytes), will only retain
# keys present in the user-specified SomaScan menu
.filterSeqIds <- function(keys, menu) {
    if ( !is.null(menu) ) {
        menu <- tolower(menu)
        menu <- if ( grepl("v5.0|11k", menu) ) {
          menu <- "v5.0"
        } else if ( grepl("v4.1|7k", menu) ) {
          menu <- "v4.1"
        } else if ( grepl("v4.0|5k", menu) ) {
          menu <- "v4.0"
        }
        keys <- keys[keys %in% somascan_menu[[menu]]] 
        unique(keys) # Some SeqIds map to 2+ Entrez IDs
    } else {
        keys
    }
}

# Internal function to match on an incomplete character string for the
# keytype being used, essentially allowing for fuzzy matching of query keys. 
# Ex: "NOTCH" will be matched and return NOTCH2, NOTCH4, etc.
# `syms` can be a single value or a vector of values
.matchKeys <- function(syms, type = "SYMBOL") {
    mapping <- switch(type,
                      "SYMBOL"   = SomaScanSYMBOL,
                      "ALIAS"    = SomaScanALIAS2PROBE,
                      "GENENAME" = SomaScanGENENAME)
    allKeys <- mappedRkeys(mapping)
    matches <- lapply(syms, function(.x) {
      r <- paste0("^", .x)
      grep(r, allKeys, value = TRUE)
    })
    unlist(matches) # May be `character(0)` if no matches were found
}
