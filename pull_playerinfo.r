require(httr)
require(jsonlite)

id  <- 'czopluoglu'

res = GET('https://api.chess.com/pub/player/czopluoglu')

fromJSON(rawToChar(res$content))

