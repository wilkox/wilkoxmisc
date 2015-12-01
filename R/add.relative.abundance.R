#' @title Add relative abundance to an OTU table
#' @rdname add_relative_abundance
#' @family add_relative_abundance
#' @export
#'
#' @description
#' Takes an OTU table in tidy format, i.e. with at least "Sample", "OTU" and
#' "Count" columns. Appends a "RelativeAbundance" column containing the
#' relative abundance (expressed as a percentage) of each OTU within each
#' sample.
#' 
#' @param OTUTable the OTU table, which must be a tidy data frame or data
#' table with at least "Sample", "OTU" and "Count" columns
#' @param silent suppress messages (defaults to true)
add.relative.abundance <- function(OTUTable, silent = TRUE) {
  Progress <- ifelse(silent, "none", "time")
  return(as.tbl(ddply(
    OTUTable,
    .(Sample),
    mutate,
    RelativeAbundance = (100 * Count) / sum(Count),
    .progress = Progress
  )))
}
