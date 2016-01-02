#' @title Standardised ggplot2 theme for publications
#' @export
#'
#' @usage Plot + theme_wilkox()
#' Plot + theme_wilkox() \%+replace\% theme(...)
theme_wilkox <- function() {
  theme_classic(base_size = 10, base_family = "Helvetica") %+replace% theme(
    panel.grid = element_blank(),
    panel.border = element_blank(),
    axis.line = element_line(lineend = "square"),
    axis.ticks.length = unit(0.5, "mm"),
    axis.title = element_text(size = 12),
    axis.text = element_text(
      size = 8,
      family = "Helvetica",
      lineheight = 10
    ),
    legend.background = element_blank(),
    legend.key = element_blank(),
    legend.text = element_text(
      lineheight = 4,
      size = 8,
      family = "Helvetica"
    ),
    legend.title = element_text(
      lineheight = 4,
      size = 8,
      family = "Helvetica",
      face = "bold"
    ),
    legend.margin = unit(-6, "mm"),
    strip.text = element_text(face = "italic"),
    strip.background = element_blank()
  )
}
