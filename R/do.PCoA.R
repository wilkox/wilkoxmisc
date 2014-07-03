do.PCoA <- function(DistanceMatrix) {

  #Return error if distance matrix is not a distance matrix
  if (! class(DistanceMatrix) == "dist") {
    warning("ERROR: Must pass a distance matrix")
    return()
  }
  
  #Do the PCoA
  PCoA <- cmdscale(DistanceMatrix, k = 2, eig = TRUE)

  #Convert PCoA output to dataframe
  DF <- data.frame(Sample = row.names(PCoA$points), PCoA1 = PCoA$points[,1], PCoA2 = PCoA$points[,2], row.names = NULL)

  #Get variance explained
  #Calculation from http://r-sig-ecology.471788.n2.nabble.com/Variability-explanations-for-the-PCO-axes-as-in-Anderson-and-Willis-2003-td6429547.html
  Eigenvalues <- eigenvals(PCoA) 
  VarianceExplained <- Eigenvalues / sum(Eigenvalues) 
  VarianceExplained1 <- 100 * signif(VarianceExplained[1], 2)
  VarianceExplained2 <- 100 * signif(VarianceExplained[2], 2)

  #Construct a list to return
  return(list(Coordinates = DF, Variance1 = VarianceExplained1, Variance2 = VarianceExplained2))
  
}
