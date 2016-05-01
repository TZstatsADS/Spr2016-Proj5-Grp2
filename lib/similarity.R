setwd('C:\\Users\\Yibo\\Documents\\gitnew\\finalproject-group-2')
load('./data/smalldata.RData')
load('./data/song_500_id.RData')
library(data.table)
library(dplyr)



colnames(smalldata)<-c('user','song','play_count')
user_allsongnum=as.data.table(smalldata)[, sum(play_count), by = .(user)]



#similarity != popularity
# similarity = average coincidence thattwo song listend by one user will happen 
similarity_of_2songs<-function(song1,song2){
  song1_set<-subset(smalldata,song1==smalldata$song)
  song2_set<-subset(smalldata,song2==smalldata$song)
  join_set<-inner_join(song1_set,song2_set,by=c("user"='user'))
  score=rep(0,dim(join_set)[1])
  for (i in 1:dim(join_set)[1]) {
    score[i]=sqrt(join_set$play_count.x[i]*join_set$play_count.y[i])/user_allsongnum[as.character(user_allsongnum$user)==as.character(join_set$user[i]),]$V1
    
  }
  similarity<-mean(score)
  return(similarity)  
  
}

pair_similarity_matrix<-c()
n=5
for ( i in 1:(n-1) ){

  for ( j in (i+1):n ){
    song1=song_id_new[i]
    song2=song_id_new[j]
    similarity=similarity_of_2songs(song1,song2)
    pair_similarity<-c(song1,song2,similarity)
    pair_similarity_matrix<-rbind(pair_similarity_matrix,pair_similarity)
    print(c(i,j))
    
  }
}
    


# data selection

#smalldata<-mydata[as.character(mydata$song) %in% as.character(song_id),]
#save(smalldata,file = 'smalldata.RData')

#song_sample_id=as.character(unique(smalldata$song))
#save(song_sample_id,file='song_3k.Rdata')

save(pair_similarity_matrix,file='so.Rdata')