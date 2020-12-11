

id = 'czopluoglu'

res = GET(paste0('https://api.chess.com/pub/player/',id,'/stats'))

fromJSON(rawToChar(res$content))
