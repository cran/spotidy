#' @title Gets multiple albums
#' @description Connects with the Spotify API and returns output from the href <https://api.spotify.com/v1/albums/>
#' @param album_ids Required. Expects a comma-separated character string of album_ids. Get Spotify Catalog information for these album_ids.
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
#' @importFrom purrr modify_depth
#' @importFrom magrittr %>%

get_albums <- function(album_ids, output = c("tidy", "raw"), limit = 20, offset = 0, token = my_token){
  
  output <- match.arg(output)
  
  response = content(GET(paste0("https://api.spotify.com/v1/albums/"), query = list(ids = album_ids, limit = limit, offset = offset), add_headers(Authorization = token)))

  albums = response$albums
  
  tidy <- data.frame(
    artist_name = albums %>% map("artists") %>% modify_depth(2, "name") %>% map_chr(paste, collapse = " ft. "),
    artist_id = albums %>% map("artists") %>% modify_depth(2, "id") %>% map_chr(paste, collapse = ","),
    album_name = albums %>% map_chr("name"),
    album_id = albums %>% map_chr("id"),
    popularity = albums %>%map_chr("popularity"),
    release_date = albums %>%map_chr("release_date"),
    total_tracks = albums %>%map_chr("total_tracks"),
    label = albums %>% map_chr("label"),
    album_type = albums %>% map_chr("type")
  )
  
  out <-  switch(output,
                 tidy = tidy,
                 raw = response)
  out
}
