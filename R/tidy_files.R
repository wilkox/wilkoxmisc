#' @title Load a data frame from a file in "tidy" format.
#'
#' @description
#' See http://vita.had.co.nz/papers/tidy-data.pdf for more info on "tidy data".
#'
#' @param file the name of the file data will be read from
#' @param ... further arguments to be passed to "read.csv"
read.tidy <- function (file, ...) {
    df <- read.csv(file, head = TRUE, row.names = NULL, sep = "\t", check.names = FALSE, ...)
    return(df)
}

write.tidy <- function (data, file) {

    if (is.matrix(data)) {
        write.table(data, file, quote = FALSE, col.names = NA, row.names = TRUE, sep = "\t")

    } else {
        write.table(data, file, quote = FALSE, sep = "\t", row.names = FALSE)
    }
}

read.tidy.dt <- function(Path) {
    DataTable <- data.table(read.tidy(Path))
    return(DataTable)
}
