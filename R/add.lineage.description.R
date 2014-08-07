#' @title Add a lineage discription to an OTU
#'
#' @description
#' Takes a named vector (assumed to be a row from a data frame with columns "OTU", "Kingdom", "Phylum", "Class" etc.) and constructs a human-readable lineage description.
#' It will try to use the binomial if possible.
#' Returns the input vector, with an additional "Description" element.
#'
#' @param OTU named vector
#' @param add_OTU add the OTU name in brackets to the end of the description.
#'
add.lineage.description <- function(OTU, add_OTU = TRUE) {

    #Function to if a taxon is functionally blank
    is.blank <- function(Taxon) {
        if (is.na(Taxon)) {
            return(TRUE)
        } else if (Taxon == "") {
            return(TRUE)
        } else {
            return(FALSE)
        }
    }

    #If species exists, return binomial
    if (! is.blank(OTU["Species"])) {
        OTU$Description <- paste(as.character(OTU$Genus), as.character(OTU$Species))
        if (add_OTU) {
            OTU$Description <- paste0(OTU$Description, " (", OTU$OTU, ")")
        }
        return(OTU)
    }

    #Identify the deepest rank for which there is taxonomic information
    Ranks <- c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus", "Species")
    deepest.rank <- function(Ranks, OTU) {
        Rank <- Ranks[length(Ranks)]
        Taxon <- OTU[Rank]
        if (is.blank(Taxon)) {
            if (length(Ranks) == 1) {
                return(FALSE)
            } else {
                return(deepest.rank(Ranks[1:length(Ranks) - 1], OTU))
            }
        } else {
            return(Rank)
        }
    }
    DeepestRank <- deepest.rank(Ranks, OTU)

    #Return deepest rank
    OTU$Description <- paste0(DeepestRank, ": ", OTU[[DeepestRank]])
    if (add_OTU) {
        OTU$Description <- paste0(OTU$Description, " (", OTU$OTU, ")")
    }
    return(OTU)
}
