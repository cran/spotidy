#' @title Gets audio features of a single track
#' @description Connects with the Spotify API and returns output from the href <https://api.spotify.com/v1/audio-features/{id}/>
#' @param track_id Required. Expects a single track_id. Get Spotify Catalog information for this track_id.
#' @param output Type of output to return from the request. Default: tidy.
#' @param limit Maximum number of results to return. Should be between 1 and 50. Default: 20.
#' @param offset The index of the first result to return. Default: 0.
#' @param token A valid access token from the Spotify Accounts service: see 
#' <https://developer.spotify.com/documentation/general/guides/authorization-guide/> for details. Default: my_token.
#' @return Default: returns a tidy dataframe with a selection of the response. Alternatively, when output is set to raw, it returns the raw output from the
#' request. 
#' @export
#' @importFrom dplyr mutate
#' @importFrom httr add_headers
#' @importFrom httr content
#' @importFrom httr GET
#' @importFrom purrr flatten_df

get_track_audio_features <- function(track_id, output = c("tidy", "raw"), limit = 20, offset = 0, token = my_token){
  
  output <- match.arg(output)
  
  response = content(GET(paste0("https://api.spotify.com/v1/audio-features/", track_id), query = list(limit = limit, offset = offset), add_headers(Authorization = token)))
  tidy = flatten_df(response) %>% 
    mutate(track_id = track_id, .before = 1)

  out <- switch(output,
                tidy = tidy,
                raw = response)
  out
}
