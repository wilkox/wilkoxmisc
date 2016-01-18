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
    # Collapse relative abundance by taxon and group
    select_("Sample", Rank, "RelativeAbundance") %>%
    group_by_("Sample", Rank) %>%
    summarise(RelativeAbundance = sum(RelativeAbundance)) %>%
    # Ensure the table is fully crossed
    complete_("Sample", Rank, fill = list("RelativeAbundance" = 0))

  # Replace unclassified taxa with "Unclassified"
  # Could not get this to work with mutate_
  TaxonTable[[Rank]] <- ifelse(
    TaxonTable[[Rank]] %in% UnclassifiedTerms,
    "Unclassified",
    as.character(TaxonTable[[Rank]])
  ) %>% factor()

  # Identify top taxa
  message("Identifying top taxa...")
  TopTaxa <- TaxonTable %>%
    # Sort by mean relative abundance
    group_by_(Rank) %>%
    summarise(MeanRelativeAbundance = mean(RelativeAbundance)) %>%
    arrange(desc(MeanRelativeAbundance)) %>%
    # Omit unclassified taxa
    filter_(! Rank == "Unclassified") %>%
    # Select top taxa
    do(.[1:n-1, ]) %>%
    select_(Rank) %>%
    unlist()

  # Rename minor and unclassified taxa
  # Could not get this to work with mutate_
  TaxonTable[[Rank]] <- ifelse(
    TaxonTable[[Rank]] %in% TopTaxa,
    as.character(TaxonTable[[Rank]]),
    "Minor/Unclassified"
  ) %>% factor()

  # Collapse the table
  message("Collapsing table...")
  TaxonTable <- TaxonTable %>%
    group_by_("Sample", Rank) %>%
    summarise(RelativeAbundance = sum(RelativeAbundance))

  # Ungroup
  TaxonTable <- TaxonTable %>%
    ungroup()
  
  # Return
  return(TaxonTable)
}

#' @rdname collapse_taxon_table
#' @export
collapse.taxon.table <- function(...) {
  warning("collapse.taxon.table is deprecated; use collapse_taxon_table instead")
}
