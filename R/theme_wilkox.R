#' @title Standardised ggplot2 theme for publications
#' @export
#'
#' @usage Plot + theme_wilkox()
#' Plot + theme_wilkox() \%+replace\% theme(...)
theme_wilkox <- function() {

  # Check if DIN fonts are available
  DIN <- "DIN" %in% names(pdfFonts()) & "DINCond-Regular" %in% names(pdfFonts()) & "DINPro-Bold" %in% names(pdfFonts())
  RegularFont <- ifelse(DIN, "DIN", "Helvetica")
  CondensedFont <- ifelse(DIN, "DINCond-Regular", "Helvetica-Narrow")
  BoldFont <- ifelse(DIN, "DINPro-Bold", "Helvetica")

  theme_bw(base_size = 8, base_family = RegularFont) %+replace% theme(
    panel.grid = element_blank(),
    panel.border = element_blank(),
    axis.line = element_line(lineend = "square"),
    axis.ticks.length = unit(1, "mm"),
    axis.title.x = element_text(vjust = 0, size = 9, family = RegularFont),
    axis.title.y = element_text(vjust = 1, angle = 90, size = 9, family = RegularFont),
    axis.text = element_text(size = 8, family = CondensedFont),
    legend.background = element_blank(),
    legend.key = element_blank(),
    legend.text = element_text(lineheight = 4, size = 10, family = CondensedFont),
    legend.title = element_text(lineheight = 4, size = 8, family = BoldFont),
    legend.margin = unit(-6, "mm"),
    strip.background = element_blank(),
    strip.text = element_text(size = 8, family = BoldFont)
  )
}
