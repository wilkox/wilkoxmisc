#' @title  (DEPRECATED) Add relative abundance to an OTU table
#' @rdname add_relative_abundance
#' @family add_relative_abundance
#' @export
#'
#' @description
#' This function is deprecated. Use the `dplyr` package and the following idiom
#' instead:
#'
#' ```
#' library(dplyr)
#' OTUTable %>%
#'  group_by(Sample) %>%
#'  mutate(RelativeAbundance = (100 * Count) / sum(Count) %>%
#'  ungroup()
#' 
#' @param OTUTable the OTU table in a tbl, with at least 'Sample', 'OTU' and
#' 'Count' columns
add_relative_abundance <- function(...) {
  stop("This function is deprecated. See ?add_relative_abundance for details.", call. = FALSE)
}

#' @title  (DEPRECATED) Add relative abundance to an OTU table
#' @rdname add.relative.abundance
#' @family add_relative_abundance
#' @export
add.relative.abundance <- function(...) {
  warning("add.relative.abundance is deprecated; use add_relative_abundance instead")
}
