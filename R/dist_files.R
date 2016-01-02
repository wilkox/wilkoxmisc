#' @title Read and write dist objects to file
#' @rdname dist_files
#' @family dist_files
#' @export
#'
#' @description
#' Read or write 'dist' objects from and to file. read_dist returns a
#' 'dist' object, read_dist_tbl returns a melted tbl.
#'
#' @param file path for reading or writing.
#' @param dist object of type 'dist' to write.
#' @param ... further arguments to pass to 'read.csv' or 'write.table'
#'
#' @seealso dist
read_dist <- function (file, ...) 
{
    return(as.dist(read.csv(file, sep = "\t", row.names = 1, ...)))
}

#' @rdname dist_files
#' @family dist_files
#' @export
write_dist <- function (dist, file, ...) {
    Matrix <- as.matrix(dist)
    write.table(Matrix, file, quote = FALSE, col.names = NA, 
        row.names = TRUE, sep = "\t", ...)
}

#' @rdname dist_files
#' @family dist_files
#' @export
read_dist_tbl <- function(Filename, Row, Column, Value) {

  Filename <- "./unweighted_unifrac_OTU_table.txt"
  Row <- "Sample1"
  Column <- "Sample2"
  Value <- "Distance"

  # Read in and melt
  Distances <- read.dist(Filename) %>%
    as.matrix() %>%
    melt() %>%
    as.tbl()
  names(Distances) <- c(Row, Column, Value)

  # Remove same-same distances
  Distances <- Distances %>%
    filter(! Sample1 == Sample2)

  # Return
  return(Distances)
}
