read.tidy <-
function (fileName, ...) 
{
    df <- read.csv(fileName, head = TRUE, row.names = NULL, sep = "\t", 
        check.names = FALSE, ...)
    return(df)
}
