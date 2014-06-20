read.tidy <-
function (fileName, ...) 
{
    df <- read.csv(fileName, head = TRUE, row.names = NULL, sep = "\t", 
        check.names = FALSE, ...)
    return(df)
}

write.tidy <-
function (dataFrame, fileName) 
{
    write.table(dataFrame, fileName, quote = FALSE, sep = "\t", 
        row.names = FALSE)
}
