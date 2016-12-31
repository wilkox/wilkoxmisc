#' @title  (DEPRECATED) Add relative abundance to an OTU table
#' @rdname add_relative_abundance
#' @family add_relative_abundance
#' @export
#'
#' @description
#' `add_relative_abundance` is deprecated. Use the `dplyr` package and the following idiom
#' instead:
#'
#' \preformatted{library(dplyr)
#' OTUTable \%>\%
#'  group_by(Sample) \%>\%
#'  mutate(RelativeAbundance = (100 * Count) / sum(Count) \%>\%
#'  ungroup}
#'
#' @param OTUTable the OTU table in a tbl, with at least 'Sample', 'OTU' and
#' 'Count' columns
add_relative_abundance <- function(...) {
  stop("`add_relative_abundance` is deprecated. See ?add_relative_abundance for details.", call. = FALSE)
}

#' @title  (DEPRECATED) Add relative abundance to an OTU table
#' @rdname add.relative.abundance
#' @family add_relative_abundance
#' @export
add.relative.abundance <- function(...) {
  stop("add.relative.abundance is deprecated; use add_relative_abundance instead", call. = FALSE)
}

#' @title (DEPRECATED) Write a tbl to tsv
#' @rdname write_tidy
#' @export
#'
#' @description
#' `write_tidy` is deprecated; use `readr::write_tsv` instead
#'
#' @seealso readr::write_tsv
#' @rdname tidy_files
#' @family tidy_files
#' @export
write_tidy <- function (...) {
  stop("`write_tidy` is deprecated; use readr::`write_tsv` instead", call. = FALSE)
}

#' @title (DEPRECATED) Read a data frame from tsv
#' @rdname read.tidy
#' @family tidy_files
#' @export
#'
#' @description 
#' `read.tidy` is deprecated; use `readr::read_tsv` instead
read.tidy <- function(...) {
  stop("`read.tidy` is deprecated; use `readr::read_tsv` instead", call. = FALSE)
}

#' @title (DEPRECATED) Write a data frame to tsv
#' @rdname write.tidy
#' @family tidy_files
#' @export
#'
#' @description 
#' `write.tidy` is deprecated; use `readr::write_tsv` instead
write.tidy <- function(...) {
  stop("`write.tidy` is deprecated; use `readr::write_tsv` instead", call. = FALSE)
}

#' @title (DEPRECATED) Ensure a tidy data frame is fully crossed
#' @export
#'
#' @description
#' `ensure.fully.crossed` is deprecated; use `tidyr::expand` instead.
#'
ensure.fully.crossed <- function(...) {
  stop("`ensure_fully_crossed` is deprecated; use 1tidyr::expand1 instead.", call. = FALSE)
}

#' @title (DEPRECATED) Move a factor level to the end of the factor
#' @export
#'
#' @description
#'
#' `move_to_end` is deprecated in favour of `forcats::fct_relevel`. `forcats`
#' can be installed as part of the `tidyverse`:
#'
#' \code{install.packages("tidyverse")}
#'
#' To use `fct_relevel` in a manner similar to `move_to_end`, take advantage of
#' \code{after = Inf}, which will move the specified factor to the end:
#' \preformatted{library(forcats)
#' fct_relevel(Phyla, "Minor/Unclassified", after = Inf)}
move_to_end <- function(...) {
  stop("`move_to_end` is deprecated. See ?move_to_end for details.", call. = FALSE)
}
