read.dist <-
function (Filename) 
{
    return(as.dist(read.csv(Filename, sep = "\t", row.names = 1)))
}

write.dist <-
function (Dist, Filename) 
{
    Matrix <- as.matrix(Dist)
    write.table(Matrix, Filename, quote = FALSE, col.names = NA, 
        row.names = TRUE, sep = "\t")
}
