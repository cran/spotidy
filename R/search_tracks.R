#' @title Search tracks based on given input
#' @description Connects with the Spotify API and returns output from the href <https://api.spotify.com/v1/search/>
#' @param track_name Required. Get Spotify Catalog information about tracks that match this input.
#' @param output Type of output to return from the request. Default: tidy.
#' @param limit Maximum number of results to return. Should be between 1 and 50. Default: 20.
#' @param offset The index of the first result to return. Default: 0.0.
#' @param token A valid access token from the Spotify Accounts service: see 
#' <https://developer.spotify.com/documentation/general/guides/authorization-guide/> for details. Default: my_token.
#' @return Default: returns a tidy dataframe with a selection of the response. Alternatively, when output is set to raw, it returns the raw output from the
#' request, or When output is set to id, it returns only the id.
#' @export
#' @importFrom httr add_headers
#' @importFrom httr content
#' @importFrom httr GET
#' @importFrom purrr map
#' @importFrom purrr map_chr
#' @importFrom purrr modify_depth
#' @importFrom magrittr %>%

search_tracks <- function(track_name, output = c("tidy", "raw", "id"), limit = 20, offset = 0, token = my_token){
  
  output <- match.arg(output)
  
  response = content(GET("https://api.spotify.com/v1/search/", query = list(q = track_name, type = "track", limit = limit, offset = offset), add_headers(Authorization = token)))
  items = response$tracks$items
  
  tidy <- data.frame(
    artist = map(items, "artists") %>% modify_depth(2, "name") %>% map_chr(paste, collapse = " ft. "),
    artist_id = map(items, "artists") %>% modify_depth(2, "id") %>% map_chr(paste, collapse = ","),
    track = map_chr(items, "name"),
    track_id = map_chr(items, "id"),
    type = map_chr(items, "type")
  )
  
  id <- tidy$track_id
  
  out <-  switch(output,
                 tidy = tidy,
                 raw = response,
                 id = id)
  out
}
