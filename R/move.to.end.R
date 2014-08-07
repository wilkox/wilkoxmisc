#' @title Move a factor level to the end of the factor
#' @export
#'
#' @description
#'
#' Move a factor level to the end of the factor.
#' Useful when plotting.
#'
#' @param Factor the factor
#' @param Level the level to move to the end
move.to.end <- function (Factor, Level) 
{
    Levels <- levels(factor(Factor))
    Levels <- Levels[Levels != Level]
    Levels <- c(Levels, Level)
    Factor <- factor(Factor, levels = Levels)
    return(Factor)
}
