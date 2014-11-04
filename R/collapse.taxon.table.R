#' @title Collapse a taxon table
#' @export
#'
#' @description
#'
#' Takes a table of taxa, or OTUs with taxonomic information e.g. a "Phylum" column, and collapses the taxa of a specified rank which are not in the top n taxa for that rank.
#' This is useful for plotting the taxonomic composition of a set of samples, where if would be impractical to plot more than a small number of taxa.
#'
#' The most abundant taxa are determined with the following process:
#'
#' 1. Relative abundances of taxa at the specified rank are summed within each sample;
#' 2. The mean relative abundance of each taxon across all samples (including samples where the relative abundance is 0) is calculated;
#' 3. The top n(ish) taxa, excluding unclassified taxa, are selected.
#'
#' @param TaxonTable taxon table in tidy format, i.e. with columns for "Sample", "RelativeAbundance", and at least one rank. Use "add.relative.abundance" first if the table only contains counts.
#' @param Rank the rank to collapse.
#' @param n the total number of groups following the collapse, including any "Minor" and "Unclassified" groups.
#' @param MergeMinorUnclassified if set to FALSE, will keep minor and unclassified taxa as separate (but still collapsed) groups.
#' @param UnclassifiedTerms taxa matching any of these terms will be considered unclassified.
#' @param silent suppress messages
collapse.taxon.table <- function (TaxonTable, Rank = "Phylum", n = 8, MergeMinorUnclassified = TRUE, UnclassifiedTerms = c(""), silent = FALSE) {

  Progress <- ifelse(silent, "none", "time")

  #Collapse relative abundance by taxon and group
  if (! silent) { message("Collapse relative abundance by taxon and group...") }
  TaxonTable <- ddply(TaxonTable, c("Sample", Rank), summarise, RelativeAbundance = sum(RelativeAbundance), .progress = Progress)

  #Cast and melt to ensure fully crossed
  if (! silent) { message("Casting and melting to ensure table is fully crossed...") }
  TaxonTable <- dcast(TaxonTable, as.formula(paste(Rank, "~ Sample")), value.var = "RelativeAbundance", fill = 0)
  TaxonTable <- melt(TaxonTable, id.var = Rank, variable.name = "Sample", value.name = "RelativeAbundance")

  #Summarise taxa by relative abundance and sort
  if (! silent) { message("Summarise taxa by relative abundance and sort...") }
  TopTaxa <- ddply(TaxonTable, c(Rank), summarise, RelativeAbundance = mean(RelativeAbundance), .progress = Progress)
  TopTaxa <- arrange(TopTaxa, desc(RelativeAbundance))

  #Omit unclassified taxa
  if (! silent) { message("Omit unclassified taxa...") }
  TopTaxa <- TopTaxa[which(! TopTaxa[[Rank]] %in% UnclassifiedTerms), ]

  #Select top taxa
  if (! silent) { message("Select top taxa...") }
  TopTaxa <- as.character(TopTaxa[[Rank]])
  TopTaxa <- TopTaxa[1:ifelse(MergeMinorUnclassified, n - 1, n - 2)]

  #Replace unclassified with "Unclassified", if requested
  if (! silent) { message("Replace unclassified with 'Unclassified', if requested...") }
  if (! MergeMinorUnclassified) {
    TaxonTable[[Rank]] <- ifelse(TaxonTable[[Rank]] %in% UnclassifiedTerms, "Unclassified", as.character(TaxonTable[[Rank]]))
    TopTaxa <- c(TopTaxa, "Unclassified")
  }

  #Replace minor taxa with the minor name
  if (! silent) { message("Replace minor taxa with the minor name...") }
  TaxonTable[[Rank]] <- ifelse(TaxonTable[[Rank]] %in% TopTaxa, as.character(TaxonTable[[Rank]]), ifelse(MergeMinorUnclassified, "Minor/Unclassified", "Minor"))

  #Collapse the table
  if (! silent) { message("Collapse the table...") }
  TaxonTable <- ddply(TaxonTable, c("Sample", Rank), summarise, RelativeAbundance = sum(RelativeAbundance), .progress = Progress)

  #Refactorise the taxon and move collapse name(s) to end
  if (! silent) { message("Refactorise the taxon and move collapse name(s) to end...") }
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
