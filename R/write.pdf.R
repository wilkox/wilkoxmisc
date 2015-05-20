#' @title Write a dataframe to pdf
#' @export
#'
#' @description
#' Write a data frame to pdf using kable (from knitr) and pandoc. Pandoc
#' must be installed. xelatex is used as the latex engine.
#'
#' @param Data dataframe to write
#' @param File file to write to (must end in .pdf)
#' @param ... further arguments to pass to kable
write.pdf <- function(Data, File, ...) {

  if(! is.data.frame(Data)) {
    return()
  }
  
  Markdown <- kable(Data, format = "markdown", ...)
  write(Markdown, "/tmp/dataframe.md")
  system(paste0("pandoc /tmp/dataframe.md -o ", File, " --latex-engine=xelatex"))
  unlink("/tmp/dataframe.md")
}
