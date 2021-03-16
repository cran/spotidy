#' @title Gets top tracks from an artist
#' @description Connects with the Spotify API and returns output from the href <https://api.spotify.com/v1/artists/{id}/top-tracks/>
#' @param artist_id Required. Get Spotify Catalog information for the top tracks of this artist_id in the given country.
#' @param country Required. ISO-code of country.
#' @param output Type of output to return from the request. Default: tidy.
#' @param limit Maximum number of results to return. Should be between 1 and 50. Default: 20.
#' @param offset The index of the first result to return. Default: 0.20.
#' @param token A valid access token from the Spotify Accounts service: see 
#' <https://developer.spotify.com/documentation/general/guides/authorization-guide/> for details. Default: my_token.
#' @return Default: returns a tidy dataframe with a selection of the response. Alternatively, when output is set to raw, it returns the raw output from the
#' request. 
#' @export
#' @importFrom httr add_headers
#' @importFrom httr content
#' @importFrom httr GET
#' @importFrom purrr map
#' @importFrom purrr map_chr
#' @importFrom purrr map_int
#' @importFrom purrr modify_depth
#' @importFrom magrittr %>%

get_artist_top_tracks <- function(artist_id, country, output = c("tidy", "raw"), limit = 20, offset = 0, token = my_token){
  
  output <- match.arg(output)
  
  response = content(GET(paste0("https://api.spotify.com/v1/artists/", artist_id, "/top-tracks"), query = list(market = country, limit = limit, offset = offset), add_headers(Authorization = token)))
  items = response$tracks
  
  tidy <- data.frame(
    artist_name = items %>% map("artists") %>% modify_depth(2, "name") %>% map_chr(paste, collapse = " ft. "),
    artist_id = items %>% map("artists") %>% modify_depth(2, "id") %>% map_chr(paste, collapse = ","),
    track = items %>% map_chr("name"),
    track_id = items %>% map_chr("id"),
    release_date = items %>% map("album") %>% map_chr("release_date"),
    popularity = items %>% map_int("popularity"),
    duration = items %>% map_int("duration_ms")
  )

  out <- switch(output,
                tidy = tidy,
                raw = response)
  out
}
