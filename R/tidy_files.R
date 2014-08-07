#' @title Load a data frame from a file in "tidy" format.
#'
#' @description
#' See http://vita.had.co.nz/papers/tidy-data.pdf for more info on "tidy data".
#'
#' @param file path of the file data will be read from
#' @param ... further arguments to be passed to "read.csv"
#'
#' @seealso "write.tidy", to write data frames in tidy format
#' @seealso "read.tidy.dt", read.tidy for data tables
read.tidy <- function (file, ...) {
    return(read.csv(file, head = TRUE, row.names = NULL, sep = "\t", check.names = FALSE, ...))
}

#' @title Write a data frame or matrix to file in "tidy" format.
#'
#' @description
#' See http://vita.had.co.nz/papers/tidy-data.pdf for more info on "tidy data".
#'
#' @param data data frame to write
#' @param file path of the file data will be written to
#'
#' @seealso "read.tidy", to read data frames in tidy format
#' @seealso "read.tidy.dt", read.tidy for data tables
write.tidy <- function (data, file) {

    if (is.matrix(data)) {
        write.table(data, file, quote = FALSE, col.names = NA, row.names = TRUE, sep = "\t")

    } else {
        write.table(data, file, quote = FALSE, sep = "\t", row.names = FALSE)
    }
}

#' @title Load a data table from a file in "tidy" format.
#'
#' @description
#' See http://vita.had.co.nz/papers/tidy-data.pdf for more info on "tidy data".
#'
#' @param file path of the file data will be read from
#' @param ... further arguments to be passed to "read.csv"
#'
#' @seealso "write.tidy", to write data frames in tidy format
#' @seealso "read.tidy", read.tidy for data frames
read.tidy.dt <- function(Path) {
    return(data.table(read.tidy(Path)))
}
