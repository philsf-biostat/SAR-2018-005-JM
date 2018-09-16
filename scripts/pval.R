pval <- function(x) {
  
  format_digits <- 5
  format_eps <- 10^(-format_digits)
  
  Hmisc::format.pval(x,
                     digits = format_digits,
                     scientific = FALSE,
                     eps = format_eps)
}