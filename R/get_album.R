#' @title Gets an album
#' @description Connects with the Spotify API and returns output from the href <https://api.spotify.com/v1/albums/{id}/>
#' @param album_id Required. Get Spotify Catalog information for this album_id.
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
#' @importFrom purrr map_chr
#' @importFrom magrittr %>%

get_album <- function(album_id, output = c("tidy", "raw"), limit = 20, offset = 0, token = my_token){
  
  output <- match.arg(output)
  
  response = content(GET(paste0("https://api.spotify.com/v1/albums/", album_id), query = list(limit = limit, offset = offset), add_headers(Authorization = token)))
  
  tidy <- data.frame(
    artist_name = response$artists %>% map_chr("name") %>% paste(collapse = " ft. "),
    artist_id = response$artists %>% map_chr("id") %>% paste(collapse = " ft. "),
    album_name = response$name,
    album_id = album_id,
    popularity = response$popularity,
    release_date = response$release_date,
    total_tracks = response$total_tracks,
    label = response$label,
    album_type = response$type
  )
  
  out <-  switch(output,
                 tidy = tidy,
                 raw = response)
  out
}
