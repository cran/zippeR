% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/zi_crosswalk.R
\name{zi_crosswalk}
\alias{zi_crosswalk}
\title{Crosswalk ZIP Codes with UDS, HUD, or a Custom Dictionary}
\usage{
zi_crosswalk(.data, input_var, zip_source = "UDS", source_var,
    source_result, year = NULL, qtr = NULL, target = NULL, query = NULL,
    by = NULL, return_max = NULL, key = NULL, return = "id")
}
\arguments{
\item{.data}{An "input object" that is data.frame or tibble that contains
ZIP Codes to be crosswalked.}

\item{input_var}{The column in the input data that contains five-digit ZIP
Codes. If the input is numeric, it will be transformed to character data
and leading zeros will be added.}

\item{zip_source}{Required character scalar or data frame; specifies the
source of ZIP Code crosswalk data. This can be one of either \code{"UDS"}
(default) or \code{"HUD"}, or a data frame containing a custom dictionary.}

\item{source_var}{Character scalar, required when \code{zip_source} is a
data frame containing a custom dictionary; specifies the column name in
the dictionary object that contains ZIP Codes.}

\item{source_result}{Character scalar, required when \code{zip_source} is a
data frame containing a custom dictionary; specifies the column name in
the dictionary object that contains ZCTAs, GEOIDs, or other values.}

\item{year}{Optional four-digit numeric scalar for year; varies based on source.
For \code{"UDS"}, years 2009 through 2023 are available. For \code{"HUD"},
years 2010 through 2024 are available. Does not need to be specified when
a custom dictionary is used.}

\item{qtr}{Numeric scalar, required when \code{zip_code} is \code{"HUD"}.
Integer value between 1 and 4, representing the quarter of the year.}

\item{target}{Character scalar, required when \code{zip_code} is \code{"HUD"}.
Can be one of \code{"TRACT"}, \code{"COUNTY"}, \code{"CBSA"},
\code{"CBSADIV"}, \code{"CD"}, and \code{"COUNTYSUB"}.}

\item{query}{Scalar or vector, required when \code{zip_code} is \code{"HUD"}.
This can be a five-digit numeric or character ZIP Code, a vector of
ZIP Codes, a two-letter character state abbreviation, or \code{"all"}.}

\item{by}{Character scalar, required when \code{zip_code} is \code{"HUD"};
the column name to use for identifying the best match for a given ZIP Code.
This could be either \code{"residential"}, \code{"commercial"}, or \code{"total"}.}

\item{return_max}{Logical scalar, required when \code{zip_code} is \code{"HUD"};
if \code{TRUE} (default), only the geography with the highest proportion
of the ZIP Code type will be returned. If the ZIP Code straddles two states,
two records will be returned. If \code{FALSE}, all records for the ZIP Code
will be returned. Where a tie exists (i.e. two geographies each contain half
of all addresses), the county with the lowest \code{GEOID} value will be
returned.}

\item{key}{Optional when \code{zip_code} is \code{"HUD"}. This should be a
character string containing your HUD API key. Alternatively, it can be
stored in your \code{.RProfile} as \code{hud_key}.}

\item{return}{Character scalar, specifies the type of output to return. Can be
one of \code{"id"} (default), which appends only the crosswalked value,
or \code{"all"}, which returns the entire crosswalk file appended to
the source data.}
}
\value{
A \code{tibble} with crosswalk values (or optionally, the full
    crosswalk file) appended based on the \code{return} argument.
}
\description{
This function compares input data containing ZIP Codes with
    a crosswalk file that will append ZCTAs. This is an important step because
    not all ZIP Codes have the same five digits as their enclosing ZCTA.
}
\examples{
# create sample data
df <- data.frame(id = c(1:3), zip5 = c("63005", "63139", "63636"))

# UDS crosswalk
\donttest{
  zi_crosswalk(df, input_var = zip5, zip_source = "UDS", year = 2022)
}

# HUD crosswalk
# you will need to replace INSERT_HUD_KEY with your own key
\dontrun{
  zi_crosswalk(df, input_var = zip5, zip_source = "HUD", year = 2023,
    qtr = 1, target = "COUNTY", query = "MO", by = "residential",
    return_max = TRUE, key = INSERT_HUD_KEY)
}

# custom dictionary
## load sample crosswalk data to simulate custom dictionary
mo_xwalk <- zi_mo_hud

# prep crosswalk
# when a ZIP Code crosses county boundaries, the portion with the largest
# number of residential addresses will be returned
mo_xwalk <- zi_prep_hud(mo_xwalk, by = "residential", return_max = TRUE)

## crosswalk
zi_crosswalk(df, input_var = zip5, zip_source = mo_xwalk, source_var = zip5,
  source_result = geoid)

}
