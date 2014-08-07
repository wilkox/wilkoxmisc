#' @title Read and write data in tidy format
#' @rdname tidy_files
#' @family tidy_files
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
#' @param ... further arguments to be passed to "read.csv"
read.tidy <- function (file, ...) {
    return(read.csv(file, head = TRUE, row.names = NULL, sep = "\t", check.names = FALSE, ...))
}
#' @rdname tidy_files
#' @family tidy_files
read.tidy.dt <- function(file, ...) {
    return(data.table(read.tidy(file, ...)))
}
#' @rdname tidy_files
#' @family tidy_files
write.tidy <- function (data, file) {

    if (is.matrix(data)) {
        write.table(data, file, quote = FALSE, col.names = NA, row.names = TRUE, sep = "\t")

    } else {
        write.table(data, file, quote = FALSE, sep = "\t", row.names = FALSE)
    }
}
