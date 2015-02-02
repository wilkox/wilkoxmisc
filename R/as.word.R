#' @title Convert an integer to a word
#' @export
#'
#' @description This is a work in progress and currently only supports integers
#' 1-20 inclusive. Very brittle!
#'
#' @param Number number to be converted
as.word <- function(Number) {

  Digits <- c("one",
              "two",
              "three",
              "four",
              "five",
              "six",
              "seven",
              "eight",
              "nine",
              "ten",
              "eleven",
              "twelve",
              "thirteen",
              "fourteen",
              "fifteen",
              "sixteen",
              "seventeen",
              "eighteen",
              "nineteen",
              "twenty"
              )

  Number <- as.integer(Number)
  return(Digits[Number])


}
