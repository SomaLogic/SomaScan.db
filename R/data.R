#' SomaScan Menu Character Vectors
#'
#' The `somascan_menu` object provides users with a quick and easy method for
#' retrieving analytes available in SomaLogic's SomaScan assay menus. The 
#' object is available whenever the `SomaScan.db` package is loaded.
#'
#' @name DataObjects
#' @aliases somascan_menu v4.1_probes v4.0_probes v4.1_analytes v4.0_analytes
#' @docType data
#'
#' @section Data Description:
#'    The `somascan_menu` object is a list of character vectors of analytes
#'    available in each SomaScan menu. The currently available vectors in
#'    the `somascan_menu` object correspond to the V4.0 ("5k") and V4.1 ("7k")
#'    menus, and are named accordingly. Older menus (ex. the V4.0 menu) contain
#'    fewer analytes than more recent releases (ex. the V4.1 menu), and each
#'    subsequent release introduces new analytes targeting additional proteins.
#'    Consequently, the V4.1 menu contains all analytes present in the V4.0
#'    menu, but the V4.0 menu does not contain all analytes in V4.1.
#'
#' @format A list containing the following elements:
#' \describe{
#'    \item{v4.1_analytes}{A character vector of SomaScan analytes. The V4.0
#'        vector contains with 4,966 elements in `SeqId` 
#'        format (e.g. `1234-56`).
#'        }
#'
#'    \item{v4.0_analytes}{A character vector of SomaScan analytes. The V4.1
#'        vector contains 7,267 elements in `SeqId` format (e.g. `1234-56`).
#'        }
#' }
#' @source \url{https://github.com/SomaLogic/SomaLogic-Data}
#' @source SomaLogic Operating Co., Inc.
#' @keywords datasets data
#' @examples
#' # View the structure of the list and its elements (i.e. SomaScan menus)
#' summary(somascan_menu)
#'
#' # Preview each element in the list
#' str(somascan_menu)
NULL
