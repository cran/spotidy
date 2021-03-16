#' @title Gets tracks from an album
#' @description Connects with the Spotify API and returns output from the href <https://api.spotify.com/v1/albums{id}/tracks/>
#' @param album_id Required. Get Spotify Catalog information for the tracks of this album_id.
#' @param output Type of output to return from the request. Default: tidy.
#' @param limit Maximum number of results to return. Should be between 1 and 50. Default: 20.
#' @param offset The index of the first result to return. Default: 0.
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

get_album_tracks <- function(album_id, output = c("tidy", "raw"), limit = 20, offset = 0, token = my_token){
  
  output <- match.arg(output)
  
  response = content(GET(paste0("https://api.spotify.com/v1/albums/", album_id, "/tracks"), query = list(limit = limit, offset = offset), add_headers(Authorization = token)))
  items = response$items
  
  tidy <- data.frame(
    artist = map(items, "artists") %>% modify_depth(2, "name") %>% map_chr(paste, collapse = " ft. "),
    artist_id = map(items, "artists") %>% modify_depth(2, "id") %>% map_chr(paste, collapse = " ft. "),
    album = get_album(album_id)$album_name,
    album_id = album_id,
    title = map_chr(items, "name"),
    track_id = map_chr(items, "id"),
    disc_number = map_int(items, "disc_number"),
    track_number = map_int(items, "track_number"),
    duration = map_int(items, "duration_ms")
  )
  
  out <-  switch(output,
                 tidy = tidy,
                 raw = response)
  out
}
