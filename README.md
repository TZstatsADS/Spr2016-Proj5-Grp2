# Final Project By Group A++++++
Ziyue JIN, Ziyue WU, Yimin ZHANG, Jingying ZHOU and Yibo ZHU

## Data
##### Source 1. Sound Analysis
* [Million Song Dataset](http://labrosa.ee.columbia.edu/millionsong/)
* Format: .h5 [Hierarchical Data Format](https://en.wikipedia.org/wiki/Hierarchical_Data_Format)  
* How we utilized our data:   
1) Made exploratory data analysis on the metadata for all 1,000,000 songs (Meta Data: 300 MB)  
2) Extracted sound analysis data from a random subset, consiting of 10,000 songs (Sound Analysis: 1.8 GB)  
          - Temporal structures: eg.beats/bar lengths distribution  
          - Loudness, timbre and pitches  
          -   
*A brief glimpse of all the blood and tears we've been through...*
```
          group                       name       otype   dclass       dim
0             /                   analysis   H5I_GROUP                   
1     /analysis            bars_confidence H5I_DATASET    FLOAT       194
2     /analysis                 bars_start H5I_DATASET    FLOAT       194
3     /analysis           beats_confidence H5I_DATASET    FLOAT       979
      ...         ...         ...         ...         ...
21    /metadata            similar_artists H5I_DATASET   STRING       100
22    /metadata                      songs H5I_DATASET COMPOUND         1
23            /                musicbrainz   H5I_GROUP                   
24 /musicbrainz              artist_mbtags H5I_DATASET   STRING         0
25 /musicbrainz        artist_mbtags_count H5I_DATASET  INTEGER         0
26 /musicbrainz                      songs H5I_DATASET COMPOUND         1

```
##### Source 2. User Preference
* [Echo Nest Tase Profile Data](The Echo Nest Taste Profile Subset)
* Format: Play count per song per user:
* How we utilized our data:    
We used this play-count data to generate a "user defined" song similiarity mesure

##### Source 3. Genre
* [Tagtraum Genre Annotations](http://www.tagtraum.com/msd_genre_datasets.html)
* Format: .cls 
* How we utilized our data:   
????????????????

##### Source 4. Lyrics BoW
* Source: [musiXmatch dataset](http://labrosa.ee.columbia.edu/millionsong/musixmatch)
* Format:.txt(BoW)


#### Data Processing
For each song we obtained 144 features. Removing songs with NAs in thoes fields, we are left with 5580 songs.
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
## Methodology
1. We used the user playcount data to work out the pairwise "distance" between songs  
2. We calculated for the pairwise difference between songs across all extracted features  
3. We used Random Forest to regress the song feature difference and "user defined features", and through the importance ranking we conclude what features contribute to the "User defined similarity"

## Exploratory Data Analysis



## Reference
Capturing the Temporal Domain
in Echonest Features
for Improved Classification Effectiveness [*On Feature Selection*](http://www.ifs.tuwien.ac.at/~schindler/pubs/AMR2012.pdf)
