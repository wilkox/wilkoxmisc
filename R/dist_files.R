#' @title Read and write dist objects to file
#' @rdname dist_files
#' @family dist_files
#'
#' @description
#' Read or write an object of type "dist" from/to file.
#'
#' @param file path for reading or writing.
#' @param dist object of type "dist" to write.
#' @param ... further arguments to pass to "read.csv" or "write.table"
#'
#' @seealso dist
read.dist <- function (file, ...) 
{
    return(as.dist(read.csv(file, sep = "\t", row.names = 1, ...)))
}

#' @rdname dist_files
#' @family dist_files
write.dist <- function (dist, file, ...) {
    Matrix <- as.matrix(dist)
    write.table(Matrix, file, quote = FALSE, col.names = NA, 
        row.names = TRUE, sep = "\t", ...)
}
