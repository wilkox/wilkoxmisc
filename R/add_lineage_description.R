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
  add_otu = true,
  italicise_binomials = "none"
) {
  OTUTable %>% 
    rowwise() %>% 
    rowwise_add_lineage_description(add_OTU, italicise_binomials) %>%
    as.tbl() %>%
    return()
}

#' @title Add lineage description to a row
#' @keywords internal
rowwise_add_lineage_description <- function(
  Row,
  add_OTU = TRUE,
  italicise_binomials = "none"
) {

  # If species exists, return binomial
  if (! is_blank(Row["Species"])) {
    Row$Description <- paste(
      as.character(Row$Genus),
      as.character(Row$Species)
    )
    if (italicise_binomials %in% c("markdown","md")) {
      Row$Description <- paste0("*", Row$Description, "*")
    } else if (italicise_binomials == "latex") {
      Row$Description <- paste0("\\textit{", Row$Description, "}")
    }
    if (add_OTU) {
      Row$Description <- paste0(Row$Description, " (", Row$OTU, ")")
    }
    return(Row)
  }

  # Identify the deepest rank for which there is taxonomic information
  DeepestRank <- deepest_rank(Row)

  # Return deepest rank if there is one, blank if not
  if (! is_blank(DeepestRank)) {
    Taxon <- Row[[DeepestRank]]
    if (DeepestRank == "Genus") {
      if (italicise_binomials %in% c("markdown", "md")) {
        Taxon <- paste0("*", Taxon, "*")
      } else if (italicise_binomials == "latex") {
        Taxon <- paste0("\\textit{", Taxon, "}")
      }
    }
    Row$Description <- paste0(DeepestRank, ": ", Taxon)
    if (add_OTU) {
      Row$Description <- paste0(Row$Description, " (", Row$OTU, ")")
    }
  } else {
    Row$Description <- "Unknown" 
    if (add_OTU) {
      Row$Description <- paste0(Row$Description, " (", Row$OTU, ")")
    }
  }
  return(Row)
}

#' @title Identify the deepest rank for which there is taxonomic information
#' @export
#'
#' @description Takes a row from a data frame with columns "OTU" and at least
#' one taxonomic rank, and returns the name of the deepest rank with
#' taxonomic information.
#'
#' @param OTU row from a data frame with columns "OTU" and at least one
#' taxonomic rank
#' @param Ranks vector with names of ranks to look for, in order
deepest_rank <- function(
  OTU,
  Ranks = c(
    "Domain",
    "Phylum",
    "Class",
    "Order",
    "Family",
    "Genus",
    "Species"
  )
) {
  Rank <- Ranks[length(Ranks)]
  if (! Rank %in% names(OTU) || is_blank(OTU[Rank])) {
    if (length(Ranks) == 1) {
      return(NA)
    } else {
      return(deepest.rank(Ranks[1:length(Ranks) - 1], OTU))
    }
  } else {
    return(Rank)
  }
}

#' @title Check if a taxon is functionally blank
#' @keywords internal
is_blank <- function(Taxon) {
  if (is.na(Taxon)) {
    return(TRUE)
  } else if (Taxon == "") {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

