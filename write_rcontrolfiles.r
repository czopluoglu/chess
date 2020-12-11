
require(httr)
require(jsonlite)
require(stringr)


# Pull the list of all players registered in a country

co <- 'TR'  # two letter ISO code for country

res     <- GET(paste0('https://api.chess.com/pub/country/',co,'/players'))
players <- fromJSON(rawToChar(res$content))$players


x = round(seq(1,length(players),length=35))

for(i in 1:34){
  ctl <- c("rm(list=ls(all=TRUE))")
  ctl <- rbind(ctl,c("require(httr)"))
  ctl <- rbind(ctl,c("require(jsonlite)"))
  ctl <- rbind(ctl,c("require(stringr)"))
  ctl <- rbind(ctl,c(""))
  ctl <- rbind(ctl,c(""))
  ctl <- rbind(ctl,c(""))
  ctl <- rbind(ctl,c("res = GET('https://api.chess.com/pub/country/TR/players')"))
  ctl <- rbind(ctl,c("players <- fromJSON(rawToChar(res$content))$players"))
  ctl <- rbind(ctl,c("d <- data.frame(player=NA,month=NA,ngames=NA)"))
  ctl <- rbind(ctl,c(""))
  ctl <- rbind(ctl,paste0("for(i in ",x[i],":",x[i+1]-1,"){"))
  ctl <- rbind(ctl,c("  ind=0"))
  ctl <- rbind(ctl,c("  while(ind==0){"))
  ctl <- rbind(ctl,c("    res = GET(paste0('https://api.chess.com/pub/player/',players[i],'/games/archives'))"))
  ctl <- rbind(ctl,c("    ind = ifelse(res$status_code==200,1,0)"))
  ctl <- rbind(ctl,c("   }"))
  ctl <- rbind(ctl,c("    arc = fromJSON(rawToChar(res$content))$archives"))
  ctl <- rbind(ctl,c("    if(length(arc)!=0){"))
  ctl <- rbind(ctl,c("      arc = str_sub(arc[which(str_sub(arc,-5,-4)==20 | str_sub(arc,-5,-4)==19)],-8,-1)"))
  ctl <- rbind(ctl,c("      if(length(arc)!=0){"))
  ctl <- rbind(ctl,c("        for(j in 1:length(arc)){"))
  ctl <- rbind(ctl,c("          ind=0"))
  ctl <- rbind(ctl,c("          while(ind==0){"))
  ctl <- rbind(ctl,c("           res = GET(paste0('https://api.chess.com/pub/player/',players[i],'/games',arc[j]))"))
  ctl <- rbind(ctl,c("           ind = ifelse(res$status_code==200,1,0)"))
  ctl <- rbind(ctl,c("          }"))
  ctl <- rbind(ctl,c("          d <- rbind(d,c(player=players[i],month=arc[j],ngames=nrow(fromJSON(rawToChar(res$content))$games)))"))
  ctl <- rbind(ctl,c("        }"))
  ctl <- rbind(ctl,c("      }"))
  ctl <- rbind(ctl,c("    }"))
  ctl <- rbind(ctl,c("print(i)"))
  ctl <- rbind(ctl,c("}"))
  ctl <- rbind(ctl,c(""))
  ctl <- noquote(ctl)
  
  write(ctl,paste0("C:/Users/cengiz/Desktop/chess/part",i,".r"))  
}
