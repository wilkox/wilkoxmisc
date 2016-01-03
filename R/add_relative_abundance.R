#' @title  Add relative abundance to an OTU table
#' @rdname add_relative_abundance
#' @family add_relative_abundance
#' @export
#'
#' @description
#' Takes an OTU tbl in tidy format, i.e. with at least 'Sample', 'OTU' and
#' 'Count' columns. Appends a 'RelativeAbundance' column containing the relative
#' abundance (expressed as a percentage) of each OTU within each sample.
#' 
#' @param OTUTable the OTU table in a tbl, with at least 'Sample', 'OTU' and
#' 'Count' columns
add_relative_abundance <- function(OTUTable) {
  OTUTable %>%
    mutate(Sample = factor(Sample)) %>%
    group_by(Sample) %>%
    mutate(RelativeAbundance = (100 * Count) / sum(Count)) %>%
    ungroup() %>%
    return()
}

#' @title  (DEPRECATED) Add relative abundance to an OTU table
#' @rdname add.relative.abundance
#' @family add_relative_abundance
#' @export
add.relative.abundance <- function(...) {
  warning("add.relative.abundance is deprecated; use add_relative_abundance instead")
}
