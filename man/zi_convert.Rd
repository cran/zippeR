% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/zi_convert.R
\name{zi_convert}
\alias{zi_convert}
\title{Convert Five-digit ZIP Codes to Three-digit ZIP Codes}
\usage{
zi_convert(.data, input_var, output_var)
}
\arguments{
\item{.data}{A data frame containing a column of five-digit ZIP Codes.}

\item{input_var}{A character scalar specifying the column name with the five-digit
ZIP Codes in the data frame.}

\item{output_var}{Optional; A character scalar specifying the column name to
store the three-digit ZIP Codes in the data frame.}
}
\value{
A tibble containing the original data frame with a new column of
  three-digit ZIP Codes.
}
\description{
This function converts five-digit ZIP Codes to three-digit ZIP
    Codes. The first three digits of a ZIP Code are known as the ZIP3 Code,
    and corresponds to the sectional center facility (SCF) that processes mail
    for a region.
}
\examples{
# add new column
## create sample data
df <- data.frame(id = c(1:3), zip5 = c("63005", "63139", "63636"))

## convert ZIP Codes to ZIP3, creating a new column
zi_convert(.data = df, input_var = zip5, output_var = zip3)

# overwrite existing column
## create sample data
df <- data.frame(id = c(1:3), zip = c("63005", "63139", "63636"))

## convert ZIP Codes to ZIP3, creating a new column
zi_convert(.data = df, input_var = zip)

}
