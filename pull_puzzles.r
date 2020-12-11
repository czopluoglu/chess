
require(rvest)
require(xml2)
require(jsonlite)
require(httr)

id  <- 'czopluoglu'

link <- paste0('https://www.chess.com/stats/puzzles/',id)

doc <- read_html(link)

html_table(doc)[[2]]


# Access to actual puzzle

'https://www.chess.com/puzzles/problem/480042')

