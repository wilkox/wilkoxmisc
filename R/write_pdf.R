#' @title Write a tbl to pdf
#' @export
#'
#' @description
#' Write a tbl to pdf using kable (from knitr) and pandoc. Pandoc must be
#' installed. xelatex is used as the latex engine.
#'
#' @param Data tbl to write
#' @param File file to write to (must end in .pdf)
#' @param ... further arguments to pass to kable
write_pdf <- function(Data, File, ...) {

  Markdown <- kable(Data, format = "markdown", ...)
  write(Markdown, "/tmp/data.md")
  system(paste0(
    "pandoc /tmp/data.md -o ",
    File,
    " --latex-engine=xelatex"
  ))
  unlink("/tmp/data.md")
}
