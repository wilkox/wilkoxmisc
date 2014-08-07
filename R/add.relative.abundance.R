#' @title Add relative abundance to an OTU table
#' @rdname add_relative_abundance
#' @family add_relative_abundance
#'
#' @description
#' Takes an OTU table in tidy format, i.e. with at least "Sample", "OTU" and "Count" columns.
#' Appends a "RelativeAbundance" column containing the relative abundance (expressed as a percentage) of each OTU within each sample.
#' 
#' "add.relative.abundance.dt" is significantly faster if the OTU table is in a data table.
#'
#' @param OTUTable the OTU table, which must be a tidy data frame or data table with at least "Sample", "OTU" and "Count" columns
add.relative.abundance <- function(OTUTable) {
  return(ddply(OTUTable, .(Sample), mutate, RelativeAbundance = (100 * Count) / sum(Count), .progress = 'time'))
}
#' @rdname add_relative_abundance
#' @family add_relative_abundance
add.relative.abundance.dt <- function(OTUTable) {
  setkey(OTUTable, Sample)
  return(OTUTable[, RelativeAbundance := (100 * Count) / sum(Count), by = list(Sample)])
}
