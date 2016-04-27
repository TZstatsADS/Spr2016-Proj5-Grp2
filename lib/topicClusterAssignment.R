ass <- fit$document_sums

assignments <- apply(ass,2,function(x) which(x!=0))

tracks <- names(documents)
result <- c()
for(i in 1:length(assignments)){
        n = length(assignments[[i]])
        for(j in 1:n){
                m<- cbind(tracks[i],assignments[[i]][j])
                result <- rbind(result,m)
        }
        
}


write.csv(result,file="~/Desktop/cluster_topics.csv")

hist(unlist(assignments))
