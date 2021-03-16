## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, eval = F----------------------------------------------------------
#  library(spotidy)

## ----get-token, eval = F------------------------------------------------------
#  my_token <- get_spotify_api_token(client_id = "***", client_secret = "***")

## ----spotidy in practice code, eval = F---------------------------------------
#  get_album_tracks("6JKkXVEljQJ1wKbRG5MywC")
#  get_album_tracks("6JKkXVEljQJ1wKbRG5MywC", "raw")
#  
#  get_album("6JKkXVEljQJ1wKbRG5MywC")
#  get_album("6JKkXVEljQJ1wKbRG5MywC", "raw")
#  
#  get_albums("6JKkXVEljQJ1wKbRG5MywC,01sfgrNbnnPUEyz6GZYlt9")
#  get_albums("6JKkXVEljQJ1wKbRG5MywC,01sfgrNbnnPUEyz6GZYlt9", "raw")
#  
#  get_artist_albums("00FQb4jTyendYWaN8pK0wa")
#  get_artist_albums("00FQb4jTyendYWaN8pK0wa", "raw")
#  
#  get_artist_top_tracks("73ZPfpfg1LBVvDEArK4l5B", "NL")
#  get_artist_top_tracks("73ZPfpfg1LBVvDEArK4l5B", "NL", "raw")
#  
#  get_artist("05GsKvp0yKuCyWQMsPAAmB")
#  get_artist("05GsKvp0yKuCyWQMsPAAmB", "raw")
#  
#  get_artists("05GsKvp0yKuCyWQMsPAAmB,73ZPfpfg1LBVvDEArK4l5B")
#  get_artists("05GsKvp0yKuCyWQMsPAAmB,73ZPfpfg1LBVvDEArK4l5B", "raw")
#  
#  get_track_audio_features("0uQcP7QVoLvaFsORsdrgNh")
#  get_track_audio_features("0uQcP7QVoLvaFsORsdrgNh", "raw")
#  
#  get_track("0uQcP7QVoLvaFsORsdrgNh")
#  get_track("0uQcP7QVoLvaFsORsdrgNh", "raw")
#  
#  get_tracks_audio_features("0uQcP7QVoLvaFsORsdrgNh,5sNESr6pQfIhL3krM8CtZn")
#  get_tracks_audio_features("0uQcP7QVoLvaFsORsdrgNh,5sNESr6pQfIhL3krM8CtZn", "raw")
#  
#  get_tracks("0uQcP7QVoLvaFsORsdrgNh,5sNESr6pQfIhL3krM8CtZn")
#  get_tracks("0uQcP7QVoLvaFsORsdrgNh,5sNESr6pQfIhL3krM8CtZn", "raw")
#  
#  search_albums("Norman Fucking Rockwell!")
#  search_albums("Norman Fucking Rockwell!", "id")
#  search_albums("Norman Fucking Rockwell!", "raw")
#  
#  search_artists("Whitney Houston")
#  search_artists("Whitney Houston", "id")
#  search_artists("Whitney Houston", "raw")
#  
#  search_tracks("What a wonderful world")
#  search_tracks("What a wonderful world", "id")
#  search_tracks("What a wonderful world", "raw")

## ----combining-search-and-get-examples, eval = F------------------------------
#  get_artist_related_artists(search_artists("Ed Sheeran", "id", 1))
#  get_album_tracks(search_albums("Blackstar", "id", 1))
#  get_track_audio_features(search_tracks("Video killed the radio star", "id", 1)

