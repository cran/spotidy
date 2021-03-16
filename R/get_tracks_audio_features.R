#' @title Gets audio features of multiple tracks
#' @description Connects with the Spotify API and returns output from the href <https://api.spotify.com/v1/audio-features/>
#' @param track_ids Required. Expects a comma-separated character string of track_ids. Get Spotify Catalog information for these track_ids.
#' @param output Type of output to return from the request. Default: tidy.
#' @param limit Maximum number of results to return. Should be between 1 and 50. Default: 20.
#' @param offset The index of the first result to return. Default: 0.
#' @param token A valid access token from the Spotify Accounts service: see 
#' <https://developer.spotify.com/documentation/general/guides/authorization-guide/> for details. Default: my_token.
#' @return Default: returns a tidy dataframe with a selection of the response. Alternatively, when output is set to raw, it returns the raw output from the
#' request. 
#' @export
#' @importFrom dplyr bind_cols
#' @importFrom httr add_headers
#' @importFrom httr content
#' @importFrom httr GET
#' @importFrom purrr flatten_df

get_tracks_audio_features <- function(track_ids, output = c("tidy", "raw"), limit = 20, offset = 0, token = my_token){
  
  output <- match.arg(output)
  
  response = content(GET("https://api.spotify.com/v1/audio-features/", query = list(ids = track_ids, limit = limit, offset = offset), add_headers(Authorization = token)))
  tidy = bind_cols(data.frame(track_id = unlist(strsplit(track_ids, ","))), flatten_df(response))
  
  out <- switch(output,
                tidy = tidy,
                raw = response)
  out
}
