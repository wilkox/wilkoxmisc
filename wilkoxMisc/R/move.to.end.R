move.to.end <-
function (Factor, Level) 
{
    Levels <- levels(factor(Factor))
    Levels <- Levels[Levels != Level]
    Levels <- c(Levels, Level)
    Factor <- factor(Factor, levels = Levels)
    return(Factor)
}
