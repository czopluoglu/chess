
require(httr)
require(jsonlite)
require(stringr)


# Pull the list of all players registered in a country

  co <- 'TR'  # two letter ISO code for country
  
  res     <- GET(paste0('https://api.chess.com/pub/country/',co,'/players'))
  players <- fromJSON(rawToChar(res$content))$players

# Initiate the matrix for data collection
  
  i=1

   res   <-  GET(paste0('https://api.chess.com/pub/player/',players[i],'/games/archives'))
   arc   <-  fromJSON(rawToChar(res$content))$archives
   res2  <-  GET(arc[1])
   d     <-  as.matrix(fromJSON(rawToChar(res2$content))$games)
   d     <- cbind(d,str_sub(arc[1],-7,-1))
   
    for(j in 2:length(arc)){
      res2 <- GET(arc[j])
      d2   <- as.matrix(fromJSON(rawToChar(res2$content))$games)[,1:16]
      if(length(dim(d2))!=0){
        d2   <- cbind(d2,str_sub(arc[j],-7,-1))
        d    <- rbind(d,d2)
      }
    }
   
   d <- cbind(d,players[i])

# Loop over all the players given a list of players
# Extract the game information form 2019 and 2020

for(i in 2:length(players)){
  
  ind=0
  while(ind==0){
      res = GET(paste0('https://api.chess.com/pub/player/',players[i],'/games/archives'))
      ind = ifelse(res$status_code==200,1,0)    
  }

  arc = fromJSON(rawToChar(res$content))$archives
      
  if(length(arc)!=0){
    
      for(j in 1:length(arc)){
        ind=0
        while(ind==0){
          res2 = GET(arc[j])
          ind = ifelse(res$status_code==200,1,0) 
        }
        
        d2   <- as.matrix(fromJSON(rawToChar(res2$content))$games)[,1:16]
        if(length(dim(d2))!=0){
          d2   <- cbind(d2,str_sub(arc[j],-7,-1))
          d2   <- cbind(d2,players[i])
          d    <- rbind(d,d2)
        }
      }
  }
  
}

##########################################################

require(ggplot2)
  
ngames <- as.data.frame(cbind(names(table(d[,17])),table(d[,17])))

ngames$year <- as.numeric(str_sub(ngames[,1],1,4))
ngames$month <- as.numeric(str_sub(ngames[,1],6,7))

ngames$year_f <- factor(ngames$year)
ngames$month_f <- factor(ngames$month,
                         labels=c('Jan','Feb','Mar','Apr','May',
                                 'Jun','Jul','Aug','Sep','Oct','Nov','Dec'))

ggplot(data=subset(ngames,
                   year==2019 | year==2020),
       aes(x=month_f,y=V2,color=year_f))+
  geom_point(size=3)+
  theme_bw()+
  xlab('Month')+
  ylab('Total Number of Games Being Played')+
  ggtitle('TURKEY - Total Number of Games Being Played on chess.com as of Dec 10')+
  scale_color_manual(values=c("#000000", "#E69F00"))+
  geom_abline(intercept = 1069369, slope = 22173,lty=2,col='gray')+
  geom_abline(intercept = 1197590, slope = 204036,lty=2,col='gray')


###############################################################################
  
  require(httr)
  
  res = GET('https://api.chess.com/pub/player/czopluoglu')
  
  fromJSON(rawToChar(res$content))
  
  
  
  
  
