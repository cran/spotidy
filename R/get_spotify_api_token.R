#' @title Gets a Spotify API token
#' @description Gets an OAuth2.0 token to connect with the Spotify API.
#' @param client_id Your client id. Required.
#' @param client_secret Your client secret. Required.
#' @seealso The vignette Connecting-with-the-Spotify-API
#' @return In case the request succeeded, a token to connect with the Spotify API. On failure, a message indicating that authentication failed.
#' @export
#' @importFrom httr accept_json
#' @importFrom httr add_headers
#' @importFrom httr authenticate
#' @importFrom httr config
#' @importFrom httr content
#' @importFrom httr GET
#' @importFrom httr POST
#' @importFrom magrittr %>%

get_spotify_api_token <- function(client_id, client_secret){
  
  response = POST("https://accounts.spotify.com/api/token",
                  authenticate(client_id, client_secret),
                  body = list(grant_type = "client_credentials"),
                  encode = "form")
  
  if(response$status_code == 200){
    message('Authentication succeeded. Consider to assign this Bearer token to a variable named "my_token". This is the default value for the token-argument of all functions that are in need of a token to connect to the Spotify API. Remember to refresh this token every hour.')
    paste0("Bearer ", content(response)$access_token)
  
    } else {
      
    message('Authentication failed. Make sure you supply a valid character string for the client id and a valid character string for the client secret.')
    }
  
}
