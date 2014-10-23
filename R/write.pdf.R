#' @title Write a dataframe to pdf
#' @export
#'
#' @description
#' Write a data frame to pdf using kable (from knitr) and pandoc. Pandoc
#' must be installed.
#'
#' @param Data dataframe to write
#' @param ... further arguments to pass to kable
write.pdf <- function(Data, ...) {

  if(! is.data.frame(Data)) {
    return()
  }
  
  Literal <- deparse(substitute(Data))
  Markdown <- kable(Data, format = "markdown", ...)
  write(Markdown, "/tmp/dataframe.md")
  system(paste0("pandoc /tmp/dataframe.md -o ", Literal, ".pdf"))
  unlink("/tmp/dataframe.md")
}
