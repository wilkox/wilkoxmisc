#' @title Standardised ggplot2 theme for publications
#' @export
#'
#' @usage Plot + theme_wilkox()
theme_wilkox <- function() {
  theme_bw(base_size = 8, base_family = "Helvetica") %+replace% theme(
    panel.grid = element_blank(),
    panel.border = element_blank(),
    axis.line = element_line(lineend = "square"),
    axis.ticks.length = unit(1, "mm"),
    axis.title.x = element_text(vjust = 0),
    axis.title.y = element_text(vjust = 1, angle = 90),
    axis.text = element_text(size = 6),
    legend.background = element_blank(),
    legend.key = element_blank(),
    legend.text = element_text(lineheight = 4, size = 6),
    legend.position = "bottom",
    legend.margin = unit(-6, "mm"),
    strip.background = element_blank(),
    strip.text = element_text(face = "italic")
  )
}
