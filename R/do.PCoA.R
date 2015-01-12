#' @title Perform PCoA on a distance matrix [DEPRECATED]
#' @export
#'
#' @description
#'
#' This function is deprecated; use cmdscale() from the vegan package instead.
# Takes a distance matrix (an object of type "dist") and performs a PCoA ordination using the "cmdscale" function from vegan, for two dimensions (k = 2).
# Returns a list with "Coordinates", a data frame of the calculated PCoA coordinates; and "Variance1" and "Variance2", the percentage variance explained by the first and second PCoA axes respectively.
#
# The method for calculating variance explained comes from \url{http://r-sig-ecology.471788.n2.nabble.com/Variability-explanations-for-the-PCO-axes-as-in-Anderson-and-Willis-2003-td6429547.html}.
#
# @param DistanceMatrix an object of type "dist", containing the distances between samples.
#
# @seealso dist for info on the dist type
# @seealso read.dist to read distance matrices from files (e.g. UniFrac distances)
# @seealso cmdscale the vegan function that performs the actual ordination
do.PCoA <- function(DistanceMatrix) {

  warning("This function is deprecated - use cmdscale() from the vegan package instead")
  return()

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
