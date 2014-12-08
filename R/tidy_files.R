#' @title Read and write data in tidy format
#' @rdname tidy_files
#' @family tidy_files
#' @export
#'
#' @description
#' "read.tidy" and "read.tidy.dt" read tidy data from a file into a data frame or data table, respectively.
#'
#' "write.tidy" writes a data frame, data table or matrix to file in tidy format.
#'
#' These functions are just convenience wrappers for the appropriate base R functions, with arguments set for tidy-formatted files. 
#'
#' See \url{http://vita.had.co.nz/papers/tidy-data.pdf} for more info on tidy data.
#'
#' @param file path of the file data will be read from
#' @param data data frame to be written
#' @param row.names passed to write.csv
#' @param ... further arguments to be passed to "read.csv" or "write.table"
read.tidy <- function (file, ...) {
    return(read.csv(file, head = TRUE, row.names = NULL, sep = "\t", check.names = FALSE, ...))
}
#' @rdname tidy_files
#' @family tidy_files
#' @export
read.tidy.dt <- function(file, ...) {
    return(data.table(read.tidy(file, ...)))
}
#' @rdname tidy_files
#' @family tidy_files
#' @export
write.tidy <- function (data, file, row.names = FALSE, ...) {

    if (is.matrix(data)) {
        write.table(data, file, quote = FALSE, col.names = NA, row.names = row.names, sep = "\t", ...)

    } else {
        write.table(data, file, quote = FALSE, sep = "\t", row.names = row.names, ...)
    }
}
