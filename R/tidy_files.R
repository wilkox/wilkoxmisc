read.tidy <- function (fileName, ...) {
    df <- read.csv(fileName, head = TRUE, row.names = NULL, sep = "\t", check.names = FALSE, ...)
    return(df)
}

write.tidy <- function (data, fileName) {

    if (is.matrix(data)) {
        write.table(data, fileName, quote = FALSE, col.names = NA, row.names = TRUE, sep = "\t")

    } else {
        write.table(data, fileName, quote = FALSE, sep = "\t", row.names = FALSE)
    }
}

read.tidy.dt <- function(Path) {
    DataTable <- data.table(read.tidy(Path))
    return(DataTable)
}
