add.relative.abundance <- function(OTUTable) {
  OTUTable <- ddply(OTUTable, .(Sample), mutate, RelativeAbundane = (100 * Count) / sum(Count), .progress = 'time')
  return(OTUTable)
}
