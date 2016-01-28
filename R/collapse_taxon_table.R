#' @title Collapse a taxon table
#' @export
#'
#' @description
#' Takes a table of taxa, or OTUs with taxonomic information e.g. a "Phylum"
#' column, and collapses the taxa of a specified rank which are not in the
#' top n taxa for that rank. This is useful for plotting the taxonomic
#' composition of a set of samples, where if would be impractical to plot
#' more than a small number of taxa.
#'
#' The most abundant taxa are determined with the following process:
#'
#' 1. Relative abundances of taxa at the specified rank are summed within
#' each sample;
#' 2. The mean relative abundance of each taxon across all samples (including
#' samples where the relative abundance is 0) is calculated;
#' 3. The top n(ish) taxa, excluding unclassified taxa, are selected.
#'
#' @param TaxonTable taxon table in tidy format, with columns named "Sample",
#' "RelativeAbundance", and at least one rank. Use "add.relative.abundance"
#' first if the table only contains counts.
#' @param Rank the rank to collapse, e.g. "Phylum".
#' @param n the desired number of taxa following the collapse, including any
#' "Minor" and "Unclassified" groups.
#' @param UnclassifiedTerms taxa matching any of these terms will be
#' considered unclassified.
collapse_taxon_table <- function(
  TaxonTable,
  Rank = "Phylum",
  n = 8,
  UnclassifiedTerms = c("")
) {

  # Prepare taxon table
  message("Preparing taxon table...")
  TaxonTable <- TaxonTable %>%
    # Rename rank to "Rank", for ease
    rename_("Rank" = Rank) %>%
    # Collapse relative abundance by taxon and group
    select(Sample, Rank, RelativeAbundance) %>%
    group_by(Sample, Rank) %>%
    summarise(RelativeAbundance = sum(RelativeAbundance)) %>%
    # Replace unclassified taxa with "Unclassified"
    mutate(Rank = ifelse(Rank %in% UnclassifiedTerms, "Unclassified", Rank)) %>%
    ungroup()

  # Identify top taxa
  message("Identifying top taxa...")
  nSamples <- TaxonTable %>% .$Sample %>% unique() %>% length()
  TopTaxa <- TaxonTable %>%
    # Sort by mean relative abundance
    group_by(Rank) %>%
    summarise(MeanRelativeAbundance = sum(RelativeAbundance) / nSamples) %>%
    arrange(desc(MeanRelativeAbundance)) %>%
    # Omit unclassified taxa
    filter(Rank != "Unclassified") %>%
    # Select top taxa
    do(.[1:n-1, ]) %>%
    select(Rank) %>%
    unlist()

  # Collapse the table
  message("Collapsing table...")
  TaxonTable <- TaxonTable %>%
    mutate(Rank = ifelse(Rank %in% TopTaxa, Rank, "Minor/Unclassified")) %>%
    group_by(Sample, Rank) %>%
    summarise(RelativeAbundance = sum(RelativeAbundance)) %>%
    ungroup() 
  
  # rename_() doesn't work for some reason 
  names(TaxonTable) <- c("Sample", Rank, "RelativeAbundance")
  
  # Return
  return(TaxonTable)
}

#' @rdname collapse_taxon_table
#' @export
collapse.taxon.table <- function(...) {
  warning("collapse.taxon.table is deprecated; use collapse_taxon_table instead")
}
