#' @title Format a taxonomic string for use with ggtext
#' @export
#'
#' @param x The string to format
#'
#' @importFrom stringr string_detect str_remove str_c str_replace_all
binom <- function(x) {

  x <- stringr::str_split(x, "[_\\s]")

  x <- purrr:::map_chr(x, function(x) {

    if (x[1] == "Deinococcus" & x[2] == "Thermus") {
      return("*Deinococcus-Thermus*")
    }

    if (x[1] == "Viruses" & x[2] == "noname") {
      return("Viruses")
    }

    if (x[1] == "Candidatus") {
      x <- str_c("*Candidatus* '", str_c(x[-1], collapse = " "), "'")
      return(x)
    }

    dplyr::case_when( 
      str_detect(x, "^sp\\.?$") ~ "sp.",   # either "sp" or "sp." not italicised
      str_detect(x, "[A-Z]{2}") ~ x,       # type/strain not italicised
      str_detect(x, "^[A-Z0-9]+$") ~ x,    # type/strain not italicised
      str_detect(x, "^unclassified$") ~ x, # unclassified not italicised
      str_detect(x, "^[oO]ther$") ~ x,     # other not italicised
      str_detect(x, "^[nN]oname$") ~ x,    # noname not italicised
      TRUE ~ str_c("*", x, "*")            # anything else italicised
    ) %>%
      str_c(collapse = " ") %>%
      str_replace_all("\\* \\*", " ")
  })

  return(x)
}
