#' @title Add lineage descriptions to an OTU table
#' @export
#'
#' @description Takes a tbl with columns 'OTU', 'Domain', 'Phylum', 'Class'
#' etc. and constructs a human-readable lineage description, the binomial if
#' possible. Returns the tbl, with an additional 'Description' column.
#'
#' @param OTUTable tbl with at least an 'OTU' column and at least one
#' taxonomic rank column 
#' @param add_OTU add the OTU name in parentheses after the description
#' @param italicise_binomials if set to 'markdown' or 'md', will wrap
#' binomials in asterisks so they appear italicised in markdown output. If
#' set to 'latex', will wrap binomials in escaped 'textit' tags.
add_lineage_description <- function(
  otutable,
  add_otu = TRUE,
  italicise_binomials = "none"
) {

  Descriptions <- otutable %>%
    select(OTU, Domain, Phylum, Class, Order, Family, Genus, Species) %>%
    rowwise() %>%
    mutate(DeepestRank = deepest_rank(unlist(.)))
  return(OTUTable)
}

#' @title Add lineage description to a row
#' @keywords internal
lineage_description_from_row <- function(
  Row,
  add_otu,
  italicise_binomials
) {

  Row <- unlist(Row)

  # Get the deepest rank available for this row
  DeepestRank <- deepest_rank(
    Row[c(
      "OTU",
      "Domain",
      "Phylum",
      "Class",
      "Order",
      "Family",
      "Genus",
      "Species"
    )] %>%
      unlist()
  )

  # If the species is available, add binomial
  if (DeepestRank == "Species") {
    Description <- paste0(Row$Genus, " ", Row$Species)
    
    # Italicise binomial if requested
    if (italicise_binomials %in% c("markdown","md")) {
       Description <- paste0("*", Description, "*")
    } else if (italicise_binomials == "latex") {
      Description <- paste0("\\textit{", Description, "}")
    }

  # If no rank is available, it's 'Unclassified'
  } else if (is.na(DeepestRank)) {
    Description <- "Unclassified"

  # Otherwise, name the rank
  } else {
    Description <- paste0(DeepestRank, ": ", Row[DeepestRank])
  }

  # Add OTU if requested
  if (add_otu) {
    Description <- paste0(Description, " (", Row["OTU"], ")")
  }

  # Return description
  return(Description)
}

#' @title Get the deepest rank from a list of ranks
#' @keywords internal
deepest_rank <- function(Row) {

  # If the last rank is blank
  if (is_blank(Row[length(Row)])) {

    # If there are no ranks left other than OTU, return NA
    if (length(Row) == 2) {
      return(NA)
    
    # Otherwise, keep looking
    } else {
      return(deepest_rank(Row[1:(length(Row) - 1)]))
    }

  # If the last rank is not blank, it is the deepest rank
  } else {
    return(names(Row)[length(Row)])
  }
}

#' @title Is a rank blank?
#' @keywords internal
is_blank <- function(Rank) {

  # Is it NA? If so, blank
  if (is.na(Rank)) {
    return(TRUE)

  # Is the rank on the list of 'blank' terms? If so, blank
  } else if (Rank %in% c("", "Unclassified")) {
    return(TRUE)

  # Otherwise, it's not blank
  } else {
    return(FALSE)
  }

}
