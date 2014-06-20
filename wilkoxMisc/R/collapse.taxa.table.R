collapse.taxa.table <-
function (TaxaTable, Taxon = "Phylum", N = 7, RelativeAbundance = "RelativeAbundance", 
    CollapseName = "Minor/Unclassified", Omit = TRUE) 
{
    names(TaxaTable)[names(TaxaTable) == RelativeAbundance] <- "RelativeAbundance"
    names(TaxaTable)[names(TaxaTable) == Taxon] <- "Taxon"
    TopTaxa <- ddply(TaxaTable, .(Taxon), summarise, RelativeAbundance = mean(RelativeAbundance))
    TopTaxa <- arrange(TopTaxa, desc(RelativeAbundance))
    if (Omit) {
        TopTaxa <- na.omit(TopTaxa)
        TopTaxa <- TopTaxa[which(TopTaxa["Taxon"] != ""), ]
    }
    TopTaxa <- TopTaxa[1:N, ]
    TopTaxa <- TopTaxa$Taxon
    TaxaTable <- within(TaxaTable, Taxon <- ifelse(Taxon %in% 
        TopTaxa, as.character(Taxon), CollapseName))
    TaxaTable <- ddply(TaxaTable, .(Sample, Taxon), summarise, 
        RelativeAbundance = sum(RelativeAbundance))
    TaxaTable$Taxon <- factor(TaxaTable$Taxon)
    TaxaTable$Taxon <- move.to.end(TaxaTable$Taxon, CollapseName)
    names(TaxaTable)[names(TaxaTable) == "RelativeAbundance"] <- RelativeAbundance
    names(TaxaTable)[names(TaxaTable) == "Taxon"] <- Taxon
    return(TaxaTable)
}
