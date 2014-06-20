write.tidy <-
function (dataFrame, fileName) 
{
    write.table(dataFrame, fileName, quote = FALSE, sep = "\t", 
        row.names = FALSE)
}
