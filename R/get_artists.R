#' @title Gets multiple artists
#' @description Connects with the Spotify API and returns output from the href <https://api.spotify.com/v1/artists/>
#' @param artist_ids Required. Expects a comma-separated character string of artist_ids. Get Spotify Catalog information for these artist_ids.
#' @param output Type of output to return from the request. Default: tidy.
#' @param limit Maximum number of results to return. Should be between 1 and 50. Default: 20.
#' @param offset The index of the first result to return. Default: 0.
#' @param token A valid access token from the Spotify Accounts service: see 
#' <https://developer.spotify.com/documentation/general/guides/authorization-guide/> for details. Default: my_token.
#' @return Default: returns a tidy dataframe with a selection of the response. Alternatively, when output is set to raw, it returns the raw output from the
#' request. 
#' @export
#' @return Default: returns a tidy dataframe with a selection of the response. Alternatively, when output is set to raw, it returns the raw output from the
#' request. 
#' @export
#' @importFrom httr add_headers
#' @importFrom httr content
#' @importFrom httr GET
#' @importFrom purrr map
#' @importFrom purrr map_chr
#' @importFrom purrr map_int
#' @importFrom magrittr %>%

get_artists <- function(artist_ids, output = c("tidy", "raw"), limit = 20, offset = 0, token = my_token){
  
  output <- match.arg(output)
  
  response = content(GET(paste0("https://api.spotify.com/v1/artists/"), query = list(ids = artist_ids, limit = limit, offset = offset), add_headers(Authorization = token)))
  
  artists = response$artists
  
  tidy <- data.frame(
    artist_name = artists %>% map_chr("name"),
    artist_id = artists %>% map_chr("id"),
    popularity = artists %>% map_int("popularity"),
    followers = artists %>% map("followers") %>% map_int("total")
  )
  
  out <-  switch(output,
                 tidy = tidy,
                 raw = response)
  out
}
