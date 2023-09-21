#' The SomaDb S4 class
#' 
#' The SomaDb class is a subclass of the ChipDb (and, by extension,
#' the AnnotationDb) class defined in the AnnotationDbi package. It is designed
#' to hold annotations for SomaScan data.

#' @importClassesFrom AnnotationDbi ChipDb
#' @exportClass SomaDb
.SomaDb <- setRefClass("SomaDb", contains = "ChipDb")
