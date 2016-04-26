rm(list=ls())
###################
# Read Files Paths
###################
<<<<<<< HEAD
setwd("~/Documents/finalproject-group-2/data/MillionSongSubset/data")
zj <- c("A/A","A/B","A/C","A/D","A/E","A/F","A/G")
files <- dir(zj, recursive=TRUE, full.names=TRUE)
=======
setwd("~/Downloads/MillionSongSubset/data")
zac<-c("A/V","A/W","A/X","A/Y","A/Z","B/A","B/B")
files_zac <- dir(zac, recursive=TRUE, full.names=TRUE)
>>>>>>> 846492ad3d4003f6d4fc827f009822bf9717259a
# # If you want to read all under current()
# files_bianbian <- dir(".", recursive=TRUE, full.names=TRUE)

###################
# Installing rhdf5#
###################
#source("http://bioconductor.org/biocLite.R")
#biocLite("rhdf5")
library(rhdf5)
##########################
# Explain a simple h5 file
##########################
h5ls("~/Documents/finalproject-group-2/data/MillionSongSubset/data/A/A/A/TRAAAAW128F429D538.h5")
# Read data under "/analysis"
<<<<<<< HEAD
termana<-h5read("~/Documents/finalproject-group-2/data/MillionSongSubset/data/A/A/A/TRAAAAW128F429D538.h5", "/analysis")
=======
termana<-h5read("/Users/zac/Documents/Courses/4249_Applied Data Science/Proj5/MillionSongSubset/data/A/A/A/TRAAAAW128F429D538.h5", "/analysis")
>>>>>>> 846492ad3d4003f6d4fc827f009822bf9717259a

###########################
# Extracting all songs data
##Note: we have three "songs" tag
########One under each "subfolder"
ptm <- proc.time()
a_songs<-c()
m_songs<-c()
b_songs<-c()

<<<<<<< HEAD
for (file in files){
=======
for (file in files_zac){
>>>>>>> 846492ad3d4003f6d4fc827f009822bf9717259a
  dfmeta <- h5read(file, "/metadata")
  dfanal <- h5read(file, "/analysis")
  dfbrai <- h5read(file, "/musicbrainz")
  a_song <-dfanal$songs
  m_song <-dfmeta$songs
  b_song <-dfbrai$songs
  
  m_songs<-rbind(m_songs,m_song)
  a_songs<-rbind(a_songs,a_song)
  b_songs<-rbind(b_songs,b_song)
}
proc.time() - ptm
###Please change the number to 1-5 accordingly
##eg. Ziyue Jin: songs_1 <-cbind()
<<<<<<< HEAD
songs_1 <- cbind(files,a_songs,m_songs,b_songs)
save(songs_1,file="songs_1.RData")
=======
songs_4<-cbind(files_zac,a_songs,m_songs,b_songs)
save(songs_4,file="songs_4.RData")
>>>>>>> 846492ad3d4003f6d4fc827f009822bf9717259a
