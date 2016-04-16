# Final Project By Group A++++++
Ziyue JIN, Ziyue WU, Yimin ZHANG, Jingying ZHOU and Yibo ZHU

### Data
* Source: [Million Song Dataset](http://labrosa.ee.columbia.edu/millionsong/)
* Format: .h5: [Hierarchical Data Format](https://en.wikipedia.org/wiki/Hierarchical_Data_Format)  
Note: Currently building up a toy model with a random subset of 10,000 songs (1.8 GB compressed)  

#### Data Processing:

```{r}
library(rhdf5)
library(wordcloud) 
library(tm)
library(NLP)
library(RColorBrewer)
library(SnowballC)
```
