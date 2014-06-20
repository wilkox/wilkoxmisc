write.dist <-
function (Dist, Filename) 
{
    Matrix <- as.matrix(Dist)
    write.table(Matrix, Filename, quote = FALSE, col.names = NA, 
        row.names = TRUE, sep = "\t")
}
