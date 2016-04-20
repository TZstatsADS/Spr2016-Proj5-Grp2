# Final Project By Group A++++++
Ziyue JIN, Ziyue WU, Yimin ZHANG, Jingying ZHOU and Yibo ZHU

### Data
* Source: [Million Song Dataset](http://labrosa.ee.columbia.edu/millionsong/)
* Format: .h5: [Hierarchical Data Format](https://en.wikipedia.org/wiki/Hierarchical_Data_Format)  
Note: Currently building up a toy model with a random subset of 10,000 songs (1.8 GB compressed)  

* Source: [musiXmatch dataset](http://labrosa.ee.columbia.edu/millionsong/musixmatch)
* Format:.txt(BoW)

* Source: [song_user_count]
* Format:
#### Data Processing:

```{r}
# Read files
library(rhdf5)
# Word Cloud
library(wordcloud) 
library(tm)
library(NLP)
library(RColorBrewer)
library(SnowballC)
```

### Reference
Capturing the Temporal Domain
in Echonest Features
for Improved Classification Effectiveness [*Explains Timbre*](http://www.ifs.tuwien.ac.at/~schindler/pubs/AMR2012.pdf)
