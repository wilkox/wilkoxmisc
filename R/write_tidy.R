#' @title Write a tbl to tsv
#' @rdname write_tidy
#' @export
#'
#' @description
#' 'write_tidy' writes a tbl to file in tidy format. It's just a convenience
#' wrapper for 'write.table' with arguments set for tidy-formatted files. 
#'
#' @param file path of the file data will be read from
#' @param data tbl to be written
#' @param ... further arguments to be passed to 'write.table'
#'
#' @seealso readr::read_tsv
#' @rdname tidy_files
#' @family tidy_files
#' @export
write_tidy <- function (data, file, ...) {
  write.table(data, file, quote = FALSE, sep = "\t", row.names = FALSE, ...)
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
#' write.tidy() is deprecated; use write_tidy() instead
read.tidy <- function(...) {
  warning("write.tidy() is deprecated; use write_tidy() instead")
}
