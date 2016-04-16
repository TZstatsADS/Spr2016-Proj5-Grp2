###################
# Read Files Paths
###################
setwd("/Users/Bianbian/Documents/Courses/4249_Applied Data Science/Proj5/MillionSongSubset/data")
bianbian<-c("A/H","A/I","A/J","A/K","A/L","A/M","A/N")
files_bianbian <- dir(bianbian, recursive=TRUE, full.names=TRUE)
# # If you want to read all under current()
# files_bianbian <- dir(".", recursive=TRUE, full.names=TRUE)

###################
# Installing rhdf5#
###################
# source("http://bioconductor.org/biocLite.R")
# biocLite("rhdf5")
library(rhdf5)
##########################
# Explain a simple h5 file
##########################
h5ls("/Users/Bianbian/Downloads/MillionSongSubset/data/A/A/A/TRAAAAW128F429D538.h5")
# Read data under "/analysis"
termana<-h5read("/Users/Bianbian/Documents/Courses/4249_Applied Data Science/Proj5/MillionSongSubset/data/A/A/A/TRAAAAW128F429D538.h5", "/analysis")

###########################
# Extracting all songs data
##Note: we have three "songs" tag
########One under each "subfolder"
ptm <- proc.time()
a_songs<-c()
m_songs<-c()
b_songs<-c()

for (file in files_bianbian){
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
final<-cbind(files_bianbian,a_songs,m_songs,b_songs)
