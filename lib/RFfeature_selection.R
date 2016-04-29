dat <- read.csv("./data/fdw0.csv")
dat <- dat[-c(1:4)]
### feature select
### remove the highly correlated variables(correlation over 0.75)
# calculate correlation matrix
correlationMatrix <- cor(dat[,-1])
# remove NA
which(is.na(correlationMatrix[,1]) == TRUE)
which(is.na(correlationMatrix[1,]) == TRUE)
correlationMatrix = correlationMatrix[-c(134:136,143,145),-c(134:136,143,145)]
# find attributes that are highly corrected (ideally >0.75)
highlyCorrelated <- c()
for ( i in 1: 139){
  for( j in (i+1):140){
    if( correlationMatrix[i,j] >= 0.75){
      highlyCorrelated = rbind(highlyCorrelated,c(i,j))
    }
  }
}
# print indexes of highly correlated attributes
print(highlyCorrelated)
# remove the highly correlated variables(second one)
dat = dat[,-(unique(highlyCorrelated[,2])+1)]
l = colnames(correlationMatrix)[highlyCorrelated[,1]]
l1 = colnames(correlationMatrix)[highlyCorrelated[,2]]
l = cbind(l,l1)
highlyCorrelated = l
write.csv(highlyCorrelated, file="output/correlative.csv") # use for interception



### feature importance by random forest

library(randomForest)
rf = randomForest(similarity~. , data=this.data,mtry=33,importance =TRUE)
variable.importance = importance(rf)
rownames(variable.importance) = name[-1]
MSE.order = variable.importance[order(variable.importance[,1],decreasing = TRUE),]
NodePurity.order = variable.importance[order(variable.importance[,2],decreasing = TRUE),]
importance.order = cbind(rownames(MSE.order),MSE.order,rownames(NodePurity.order),NodePurity.order)
rownames(importance.order) = c(1:100)
colnames(importance.order) = c("MSE.order","%IncMSE","IncNodePurity","NodePurity.order","%IncMSE","IncNodePurity")
save( importance.order,file ="./output/Variable.Importance.RData")

par(mfrow=c(1,2))
barplot(as.numeric(importance.order[1:10,2]),names.arg = importance.order[1:10,1],
        col="cornflowerblue",cex.names=0.7,las=2, ylab = "decreace in MSE",main="10 most importance variable by MSE")
barplot(as.numeric(importance.order[1:10,6]),names.arg = importance.order[1:10,4],
        col="cornflowerblue",cex.names=0.7,las=2, ylab = "increase in Node Purity",main="10 most importance variable by NodePurity")
filename = 'output/RFimortance.png'
dev.copy(device=png, file=filename, height=800, width=800)
dev.off()



### use the first 10 important variables by MSE decreasing do hierarchical clustering
use.var = importance.order[1:10,1]
load("data/fulldata.RData")
var.ind = match(use.var[,1],colnames(fulldata))
ind = match(tid,fulldata$track_id) ### use the id that has the lyric information
new.dat = fulldata[ind,c(14,var.ind)]
col.sd = apply(new.dat[,-1],2,sd)
new.dat.sd = new.dat[,-1]
for ( i in 1:10 ){
  new.dat.sd[,i] = new.dat[,(i+1)]/col.sd[i] 
}


hc.out = hclust(dist(new.dat.sd))
k <- 3
library(plotrix)
library(circlize)
cols <- rainbow_hcl(k)
dend <- as.dendrogram(hc.out)
dend <- color_branches(dend, k = k)
plot(dend, xlab='',sub='')
par(mar = rep(0,4))
circlize_dendrogram(dend,labels =FALSE)



