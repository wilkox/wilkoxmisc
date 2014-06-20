read.dist <-
function (Filename) 
{
    return(as.dist(read.csv(Filename, sep = "\t", row.names = 1)))
}
