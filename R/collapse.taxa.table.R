collapse.taxa.table <- function (TaxaTable, Rank = "Phylum", n = 8, Groups = c("Sample"), MergeMinorUnclassified = TRUE) {

  #Collapse relative abundance by taxon and group
  TaxaTable <- ddply(TaxaTable, c(Groups, Rank), summarise, RelativeAbundance = sum(RelativeAbundance))

  #Summarise taxa by relative abundance and sort
  TopTaxa <- ddply(TaxaTable, c(Rank), summarise, RelativeAbundance = mean(RelativeAbundance))
  TopTaxa <- arrange(TopTaxa, desc(RelativeAbundance))

  #Omit blank taxa
  TopTaxa <- TopTaxa[which(TopTaxa[Rank] != ""), ]

  #Select top taxa
  TopTaxa <- as.character(TopTaxa[[Rank]])
  TopTaxa <- TopTaxa[1:ifelse(MergeMinorUnclassified, n - 1, n - 2)]

  #Replace unclassified with "Unclassified", if requested
  if (! MergeMinorUnclassified) {
    TaxaTable[[Rank]] <- ifelse(TaxaTable[[Rank]] == "", "Unclassified", as.character(TaxaTable[[Rank]]))
    TopTaxa <- c(TopTaxa, "Unclassified")
  }

  #Replace minor taxa with the minor name
  TaxaTable[[Rank]] <- ifelse(TaxaTable[[Rank]] %in% TopTaxa, as.character(TaxaTable[[Rank]]), ifelse(MergeMinorUnclassified, "Minor/Unclassified", "Minor"))

  #Collapse the table
  TaxaTable <- ddply(TaxaTable, c(Groups, Rank), summarise, RelativeAbundance = sum(RelativeAbundance))

  #Refactorise the taxon and move collapse name(s) to end
  TaxaTable[Rank] <- factor(TaxaTable[[Rank]])
  if (MergeMinorUnclassified) {
    TaxaTable[[Rank]] <- move.to.end(TaxaTable[[Rank]], "Minor/Unclassified")
  } else {
    TaxaTable[[Rank]] <- move.to.end(TaxaTable[[Rank]], "Minor")
    TaxaTable[[Rank]] <- move.to.end(TaxaTable[[Rank]], "Unclassified")
  }

  return(TaxaTable)
}
