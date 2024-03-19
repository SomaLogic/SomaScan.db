#' SomaScan Menu Character Vectors
#'
#' The `somascan_menu` object provides users with a quick and easy method for
#' retrieving analytes available in SomaLogic's SomaScan assay menus. The 
#' object is available whenever the `SomaScan.db` package is loaded.
#'
#' @name DataObjects
#' @aliases somascan_menu probe_list somascan_analytes
#' @docType data
#'
#' @section Data Description:
#'    The `somascan_menu` object is a list of character vectors of analytes
#'    available in each SomaScan menu. The currently available vectors in
#'    the `somascan_menu` object correspond to the V4.0 ("5k"), V4.1 ("7k"), 
#'    and V5.0 ("11k") menus, and are named accordingly. Older menus (ex. the 
#'    5k menu) contain fewer analytes than more recent releases (ex. the 
#'    11k menu), and each subsequent release introduces new analytes targeting 
#'    additional protein epitopes. Consequently, the 7k menu contains all 
#'    analytes  present in the 5k menu, but the 5k menu does not contain all 
#'    analytes in the 7k menu.
#'
#' @format A list containing the following elements:
#' \describe{
#'    \item{v4.0_analytes}{A character vector of SomaScan analytes from V4.0 
#'        of the SomaScan menu (commonly referred to as "5k"). The V4.0 vector 
#'        contains 4,966 elements in `SeqId` format (e.g. `1234-56`).
#'        }
#'
#'    \item{v4.1_analytes}{A character vector of SomaScan analytes from V4.1 
#'        of the SomaScan menu (commonly referred to as "7k"). The V4.1 vector 
#'        contains 7,267 elements in `SeqId` format (e.g. `1234-56`).
#'        }
#'        
#'    \item{v5.0_analytes}{A character vector of SomaScan analytes from V5.0 
#'        of the SomaScan menu (commonly referred to as "11k"). The V5.0
#'        vector contains 10,731 elements in `SeqId` format (e.g. `1234-56`).
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
