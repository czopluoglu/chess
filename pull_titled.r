

#Valid title abbreviations are: GM, WGM, IM, WIM, FM, WFM, NM, WNM, CM, WCM.

title <- 'GM'

res = GET(paste0('https://api.chess.com/pub/titled/',title))

fromJSON(rawToChar(res$content))$players

