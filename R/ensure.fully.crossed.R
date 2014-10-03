#' @title Ensure a tidy data frame is fully crossed
#' @export
#'
#' @description
#' Takes a data frame in tidy format, and ensures it represents a fully crossed table
#' with respect to selected variables.
#'
#' @param Data a data frame in tidy format
#' @param id.vars names of columns in Data representing the ID variables (i.e. the
#' variable or variables which represent a single observation; the left hand side
#' of the crossed matrix)
#' @param variable.var name of column in Data containing variable names (i.e. the column
#' names of the crossed matrix)
#' @param value.var name of column in Data containing the values
#' @param fill (optional) fill for missing values, defaults to 0
ensure.fully.crossed <- function(Data, id.vars, variable.var, value.var, fill = 0) {
  Data <- dcast(Data, as.formula(paste0(paste(id.vars, collapse = " + "), " ~ ", variable.var)), value.var = value.var, fill = fill)
  Data <- melt(Data, id.vars = id.vars, variable.name = variable.var, value.name = value.var)
  return(Data)
}
