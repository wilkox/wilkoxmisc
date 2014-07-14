add.relative.abundance <- function(OTUTable) {
  return(ddply(OTUTable, .(Sample), mutate, RelativeAbundance = (100 * Count) / sum(Count), .progress = 'time'))
}
