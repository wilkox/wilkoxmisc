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
    axis.title = element_text(size = 10, face = "bold"),
    axis.text = element_text(
      size = 8,
      family = "Helvetica",
      lineheight = 10
    ),
    legend.text = element_text(
      lineheight = 4,
      size = 8,
      family = "Helvetica"
    ),
    legend.title = element_text(
      lineheight = 4,
      size = 10,
      family = "Helvetica",
      face = "bold"
    ),
    strip.text = element_text(size = 8, face = "italic"),
    strip.background = element_blank()
  )
}
