#' @title Add a lineage discription to an OTU
#' @export
#'
#' @description
#' Takes a data frame with columns "OTU", "Kingdom", "Phylum", "Class" etc. and constructs a human-readable lineage description.
#' It will try to use the binomial if possible.
#' Returns the data frame, with an additional "Description" column.
#'
#' @param OTUTable data frame with at least an "OTU" column and at least one taxonomic rank column
#' @param add_OTU add the OTU name to the description
#' @param italicise_binomials if set to "markdown" or "md", will wrap binomials in asterisks so they appear italicised in markdown output
add.lineage.description <- function(OTUTable, add_OTU = TRUE, italicise_binomials = NULL) {

  #Operate row-by-row
  if (nrow(OTUTable) > 1) {
    return(rbind(add.lineage.description(OTUTable[1,]), add.lineage.description(OTUTable[2:nrow(OTUTable), ])))  
  }

  #If species exists, return binomial
  if (! is.blank(OTUTable["Species"])) {
    OTUTable$Description <- paste(as.character(OTUTable$Genus), as.character(OTUTable$Species))
    if (italicise_binomials == "markdown" | italicise_binomials == "md") {
      OTUTable$Description <- paste0("*", OTUTable$Description, "*")
    }
    if (add_OTU) {
      OTUTable$Description <- paste0(OTUTable$Description, " (", OTUTable$OTU, ")")
    }
    return(OTUTable)
  }

  #Identify the deepest rank for which there is taxonomic information
  DeepestRank <- deepest.rank(OTUTable)

  #Return deepest rank if there is one, blank if not
  if (! is.na(DeepestRank)) {
    OTUTable$Description <- paste0(DeepestRank, ": ", OTUTable[[DeepestRank]])
    if (add_OTU) {
      OTUTable$Description <- paste0(OTUTable$Description, " (", OTUTable$OTU, ")")
    }
  } else {
    OTUTable$Description <- "" 
  }
  return(OTUTable)
}

#' @title Identify the deepest rank for which there is taxonomic information
#' @export
#'
#' @description
#' Takes a row from a data frame with columns "OTU" and at least one taxonomic rank, and returns the name of the deepest rank with taxonomic information.
#'
#' @param OTU row from a data frame with columns "OTU" and at least one taxonomic rank
#' @param Ranks vector with names of ranks to look for, in order
#'
deepest.rank <- function(OTU, Ranks = c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus", "Species")) {
  Rank <- Ranks[length(Ranks)]
  if (! Rank %in% names(OTU) || is.blank(OTU[Rank])) {
    if (length(Ranks) == 1) {
      return(NA)
    } else {
      return(deepest.rank(Ranks[1:length(Ranks) - 1], OTU))
    }
  } else {
    return(Rank)
  }
}

#Function to check if a taxon is functionally blank
#' @keywords internal
is.blank <- function(Taxon) {
  if (is.na(Taxon)) {
    return(TRUE)
  } else if (Taxon == "") {
    return(TRUE)
  } else {
    return(FALSE)
  }
}
