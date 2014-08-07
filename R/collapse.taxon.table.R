#' @title Collapse a taxon table
#' @export
#'
#' @description
#'
#' Takes a table of taxa, or OTUs with taxonomic information e.g. a "Phylum" column, and collapses the taxa of a specified rank which are not in the top n taxa for that rank.
#' This is useful for plotting the taxonomic composition of a set of samples, where if would be impractical to plot more than a small number of taxa.
#'
#' @param TaxonTable taxon table in tidy format, i.e. with columns for "Sample", "RelativeAbundance", and at least one rank. Use "add.relative.abundance" first if the table only contains counts.
#' @param Rank the rank to collapse.
#' @param n the total number of groups following the collapse, including any "Minor" and "Unclassified" groups.
#' @param Goups The grouping factor(s), for example if the group mean is to be taken after collapsing.
#' @param MergeMinorUnclassified if set to FALSE, will keep minor and unclassified taxa as separate (but still collapsed) groups.
#' @param UnclassifiedTerms taxa matching any of these terms will be considered unclassified.
collapse.taxon.table <- function (TaxonTable, Rank = "Phylum", n = 8, Groups = c("Sample"), MergeMinorUnclassified = TRUE, UnclassifiedTerms = c("")) {

  #Collapse relative abundance by taxon and group
  message("Collapse relative abundance by taxon and group...")
  TaxonTable <- ddply(TaxonTable, c(Groups, Rank), summarise, RelativeAbundance = sum(RelativeAbundance), .progress = "time")

  #Summarise taxa by relative abundance and sort
  message("Summarise taxa by relative abundance and sort...")
  TopTaxa <- ddply(TaxonTable, c(Rank), summarise, RelativeAbundance = mean(RelativeAbundance), .progress = "time")
  TopTaxa <- arrange(TopTaxa, desc(RelativeAbundance))

  #Omit blank taxa
  message("Omit blank taxa...")
  TopTaxa <- TopTaxa[which(TopTaxa[Rank] != ""), ]

  #Select top taxa
  message("Select top taxa...")
  TopTaxa <- as.character(TopTaxa[[Rank]])
  TopTaxa <- TopTaxa[1:ifelse(MergeMinorUnclassified, n - 1, n - 2)]

  #Replace unclassified with "Unclassified", if requested
  message("Replace unclassified with 'Unclassified', if requested...")
  if (! MergeMinorUnclassified) {
    TaxonTable[[Rank]] <- ifelse(TaxonTable[[Rank]] %in% UnclassifiedTerms, "Unclassified", as.character(TaxonTable[[Rank]]))
    TopTaxa <- c(TopTaxa, "Unclassified")
  }

  #Replace minor taxa with the minor name
  message("Replace minor taxa with the minor name...")
  TaxonTable[[Rank]] <- ifelse(TaxonTable[[Rank]] %in% TopTaxa, as.character(TaxonTable[[Rank]]), ifelse(MergeMinorUnclassified, "Minor/Unclassified", "Minor"))

  #Collapse the table
  message("Collapse the table...")
  TaxonTable <- ddply(TaxonTable, c(Groups, Rank), summarise, RelativeAbundance = sum(RelativeAbundance), .progress = "time")

  #Refactorise the taxon and move collapse name(s) to end
  message("Refactorise the taxon and move collapse name(s) to end...")
  TaxonTable[Rank] <- factor(TaxonTable[[Rank]])
  if (MergeMinorUnclassified) {
    TaxonTable[[Rank]] <- move.to.end(TaxonTable[[Rank]], "Minor/Unclassified")
  } else {
    TaxonTable[[Rank]] <- move.to.end(TaxonTable[[Rank]], "Minor")
    TaxonTable[[Rank]] <- move.to.end(TaxonTable[[Rank]], "Unclassified")
  }

  return(TaxonTable)
}

#' @title Synonym for "collapse.taxon.table"
#' @export
#' @description Synonym for "collapse.taxon.table"; deprecated.
collapse.taxa.table <- function(...) {
    warning("collapse.taxa.table is deprecated; use collapse.taxon.table instead")
    collapse.taxon.table(...)
    }
