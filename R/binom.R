#' @title Format a taxonomic string for use with ggtext
#' @export
#'
#' @param x The string to format
binom <- function(x) {

  x <- stringr::str_split(x, "[_\\s]")

  x <- purrr:::map_chr(x, ~ dplyr::case_when( 
      stringr::str_detect(.x, "^sp\\.?$") ~ "sp.",    # either "sp" or "sp." not italicised
      stringr::str_detect(.x, "[a-z]{2}") ~ .x,       # type/strain not italicised
      stringr::str_detect(.x, "^[a-z0-9]+$") ~ .x,    # type/strain not italicised
      stringr::str_detect(.x, "^unclassified$") ~ .x, # unclassified not italicised
      TRUE ~ stringr::str_c("*", .x, "*")             # anything else italicised
    ) %>%
    str_c(collapse = " ") %>%
    str_replace_all("\\* \\*", " ")
  )

  return(x)
}
