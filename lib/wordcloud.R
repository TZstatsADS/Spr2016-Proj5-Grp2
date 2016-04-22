# install.packages("wordcloud")
# install.packages("tm")
# install.packages("SnowballC")
library(wordcloud) 
library(tm)
library(NLP)
library(RColorBrewer)
library(SnowballC)
library(rhdf5)

ptm<-proc.time()
tags<-c()
for (file in files_all){
  tag<-h5read(file, "/musicbrainz/artist_mbtags")
  tags<-append(tags,tag)
}
proc.time() - ptm
#=========
title <- Corpus(VectorSource(tags))
title <- tm_map(title, content_transformer(tolower))
title <- tm_map(title, PlainTextDocument)
title <- tm_map(title, stripWhitespace)
title <- tm_map(title, removePunctuation)
title <- tm_map(title, removeWords, c(stopwords('english')))
wordcloud(title, scale=c(5,0.5), max.words=100, random.order=FALSE, 
          rot.per=0.35, use.r.layout=FALSE, colors=brewer.pal(8, 'Dark2'))