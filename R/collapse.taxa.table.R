collapse.taxa.table <- function (TaxaTable, Rank = "Phylum", n = 7, RelativeAbundance = "RelativeAbundance", CollapseName = "Minor/Unclassified", Groups = c("Sample"), Omit = TRUE) {

  #Rename Rank and RelativeAbundance columns for convenience
  names(TaxaTable)[names(TaxaTable) == RelativeAbundance] <- "RelativeAbundance"
  names(TaxaTable)[names(TaxaTable) == Rank] <- "Rank"

  #Collapse relative abundance by taxon and group
  TaxaTable <- ddply(TaxaTable, c(Groups, "Rank"), summarise, RelativeAbundance = sum(RelativeAbundance))

  #Summarise taxa by relative abundance and sort
  TopTaxa <- ddply(TaxaTable, .(Rank), summarise, RelativeAbundance = mean(RelativeAbundance))
  TopTaxa <- arrange(TopTaxa, desc(RelativeAbundance))

  #Omit na/'' taxa
  if (Omit) {
    TopTaxa <- na.omit(TopTaxa)
    TopTaxa <- TopTaxa[which(TopTaxa["Rank"] != ""), ]
  }

  #Select top n taxa
  TopTaxa <- TopTaxa[1:n, ]
  TopTaxa <- TopTaxa$Rank

  #Replace non-top taxa with the collapse name
  TaxaTable <- within(TaxaTable, Rank <- ifelse(Rank %in% TopTaxa, as.character(Rank), CollapseName))

  #Collapse the table
  TaxaTable <- ddply(TaxaTable, c(Groups, "Rank"), summarise, RelativeAbundance = sum(RelativeAbundance))

  #Refactorise the taxon and move collapse name to end
  TaxaTable$Rank <- factor(TaxaTable$Rank)
  TaxaTable$Rank <- move.to.end(TaxaTable$Rank, CollapseName)

  #Restore original taxon and relative abundance names
  names(TaxaTable)[names(TaxaTable) == "RelativeAbundance"] <- RelativeAbundance
  names(TaxaTable)[names(TaxaTable) == "Rank"] <- Rank

  return(TaxaTable)
}
