add.lineage.description <- function(OTU) {

    #Check if a taxon is functionally blank
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
        return(paste(as.character(OTU$Genus), as.character(OTU$Species)))
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
    return(paste0(DeepestRank, ": ", OTU[[DeepestRank]]))
}
