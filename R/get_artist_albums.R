#' @title Gets albums from an artist
#' @description Connects with the Spotify API and returns output from the href <https://api.spotify.com/v1/artists/{id}/albums/>
#' @param artist_id Required. Get Spotify Catalog information for the albums of this artist_id.
#' @param output Type of output to return from the request. Default: tidy.
#' @param limit Maximum number of results to return. Should be between 1 and 50. Default: 20.
#' @param offset The index of the first result to return. Default: 0..
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

get_artist_albums <- function(artist_id, output = c("tidy", "raw"), limit = 20, offset = 0, token = my_token){
  
  output <- match.arg(output)
  
  response = content(GET(paste0("https://api.spotify.com/v1/artists/", artist_id, "/albums"), query = list(limit = limit, offset = offset), add_headers(Authorization = token)))
  items = response$items
  
  tidy <- data.frame(
    artist = items %>% map("artists") %>% modify_depth(2, "name") %>% map_chr(paste, collapse = " ft. "),
    artist_id = items %>% map("artists") %>% modify_depth(2, "id") %>% map_chr(paste, collapse = ","),
    album = items %>% map_chr("name"),
    album_id = items %>% map_chr("id"),
    type = items %>% map_chr("type"),
    total_tracks = items %>% map_int("total_tracks"),
    release_date = items %>% map_chr("release_date")
  )
  
  out <- switch(output,
                tidy = tidy,
                raw = response)
  out
}
