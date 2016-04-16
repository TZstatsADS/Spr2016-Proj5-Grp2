source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)
# Explain
h5ls("/Users/Bianbian/Downloads/MillionSongSubset/data/A/A/A/TRAAAAW128F429D538.h5")
# Read data under /analysis
termana<-h5read("/Users/Bianbian/Downloads/MillionSongSubset/data/B/D/D/TRBDDQF12903CB309A.h5", "/analysis")