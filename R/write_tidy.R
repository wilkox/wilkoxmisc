#' @title (DEPRECATED) Write a tbl to tsv
#' @rdname write_tidy
#' @export
#'
#' @description
#' write_tidy() is deprecated; use readr::write_tsv() instead
#'
#' @seealso readr::write_tsv
#' @rdname tidy_files
#' @family tidy_files
#' @export
write_tidy <- function (...) {
  warning("write_tidy() is deprecated; use readr::write_tsv() instead")
}

#' @title (DEPRECATED) Read a data frame from tsv
#' @rdname read.tidy
#' @family tidy_files
#' @export
#'
#' @description 
#' read.tidy() is deprecated; use readr::read_tsv() instead
read.tidy <- function(...) {
  warning("read.tidy() is deprecated; use readr::read_tsv() instead")
}

#' @title (DEPRECATED) Write a data frame to tsv
#' @rdname write.tidy
#' @family tidy_files
#' @export
#'
#' @description 
#' write.tidy() is deprecated; use readr::write_tsv() instead
write.tidy <- function(...) {
  warning("write.tidy() is deprecated; use readr::write_tsv() instead")
}
