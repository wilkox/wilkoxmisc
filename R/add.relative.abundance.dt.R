add.relative.abundance.dt <- function(OTUTable) {
  setkey(OTUTable, Sample)
  return(OTUTable[, RelativeAbundance := (100 * Count) / sum(Count), by = list(Sample)])
}
