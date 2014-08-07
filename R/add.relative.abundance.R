#' @title Add relative abundance to an OTU table
#'
#' @description
#' Takes an OTU table in tidy format, i.e. with at least "Sample", "OTU" and "Count" columns.
#' Appends a "RelativeAbundance" column containing the relative abundance (expressed as a percentage) of each OTU within each sample.
#'
#' @param OTUTable the OTU table, which must be a tidy data frame with at least "Sample", "OTU" and "Count" columns
add.relative.abundance <- function(OTUTable) {
  return(ddply(OTUTable, .(Sample), mutate, RelativeAbundance = (100 * Count) / sum(Count), .progress = 'time'))
}
