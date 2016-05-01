setwd("~/Desktop/studying/w4249 applied data models/finalproject-group-2")

load("data/fulldata.RData")
### put the no order qualitative variables after the quantitative variables
colnames(fulldata)
fac.list = c("filename", "audio_md5","track_id","artist_7digitalid" ,"artist_id","artist_mbid","artist_name","release_7digitalid",
             "artist_playmeid","release","song_id","title","track_7digitalid")
fac.ind = which(colnames(fulldata) %in% fac.list)
fulldata.c =cbind(fulldata[,-fac.ind],fulldata[,fac.ind])
save(fulldata.c,file ="data/fulldata_c.RData")
rm(fulldata)

### take the sample 500
load("data/song_500_id.RData")
song_sample_id = as.character(song_sample_id)
sample.data = fulldata.c[which(fulldata.c$song_id %in% song_sample_id),]
save(sample.data,file ="data/sample500.RData")



### compute the song_difference matrix, each song save in one file to save the memory 
rm(fulldata.c,fac.ind,fac.list,song_sample_id)
for ( i in 1:499 ){
  difference =c()
  for ( j in (i+1):500){
    this.dif1 = sample.data[i,1:132]-sample.data[j,1:132]
    this.dif2 = ifelse(sample.data[i,133:145] == sample.data[j,133:145],1,0) # same 1, not same 0
    this.dif = as.vector(c(sample.data$song_id[c(i,j)],this.dif1,this.dif2))   
    difference = rbind(difference,this.dif)
  }
  cat(i,"\n")
  save(difference,file=paste0("data/difference500/diff_",i,".RData"))
}

### combine the each file together
rm(list=ls())
diff.500 = c()
for ( i in 1:499){
  this.file = paste0("data/difference500/diff_",i,".RData")
  load(this.file)
  diff.500 = rbind(diff.500,difference)
  cat(i,"\n")
}
load("data/fulldata_c.RData")
colnames(diif.500)[3:147] = colnames(fulldata.c)
save(diff.500,file="data/diff_500.RData")

### combine data
load("data/y.RData")
rownames(y) = c(1:124750)
rownames(diff.500) = c(1:124750)
dat = cbind(y,diff.500)
dat = dat[,-c(4:5)]
for ( i in 1:148){
  dat[,i] = unlist(dat[,i])
} 
save(dat, file = "./output/500songs_full_data.RData")