# LDAvisData can be installed from GitHub via 'devtools::install_github("cpsievert/LDAvisData")'
load("~/Desktop/lyr.RData")
f_words<-colSums(lyr[,-1])
stop_words <- stopwords("English")
del <- colnames(lyr[,-1]) %in% stop_words | f_words < 5
term.table <- f_words[!del]
vocab_m <- names(term.table)
index <- match(vocab_m,colnames(lyr))

lyr_cleaned<-lyr[,index]
trackid <- lyr[,1]
rownames(lyr_cleaned) <- trackid


#pre
# read in some stopwords:

# now put the documents into the format required by the lda package:
get.terms <- function(x) {
        index <-which(x != 0)
        rbind(as.integer(index - 1), as.integer(rep(1, length(index))))
}

documents <- apply(lyr_cleaned,1, get.terms)

##
D <- length(documents)  # number of documents (2,000)
W <- length(vocab_m)  # number of terms in the vocab (14,568)
doc.length <- sapply(documents, function(x) sum(x[2, ]))  # number of tokens per document [312, 288, 170, 436, 291, ...]
N <- sum(doc.length)  # total number of tokens in the data (546,827)
term.frequency <- as.integer(term.table)  # frequencies of terms in the corpus [8939, 5544, 2411, 2410, 2143, ...]

##
K <- 10
G <- 5000
alpha <- 0.02
eta <- 0.02

# Fit the model:
library(lda)
set.seed(357)
#t1 <- Sys.time()
fit <- lda.collapsed.gibbs.sampler(documents = documents, K = K, vocab = vocab_m, 
                                   num.iterations = G, alpha = alpha, 
                                   eta = eta, initial = NULL, burnin = 0,
                                   compute.log.likelihood = TRUE)
#t2 <- Sys.time()
#t2 - t1  # about 24 minutes on laptop

##
theta <- t(apply(fit$document_sums + alpha, 2, function(x) x/sum(x)))
phi <- t(apply(t(fit$topics) + eta, 2, function(x) x/sum(x)))

##
Lyrics <- list(phi = phi,
                     theta = theta,
                     doc.length = doc.length,
                     vocab = vocab_m,
                     term.frequency = term.frequency)

##
library(LDAvis)

# create the JSON object to feed the visualization:
json <- createJSON(phi = Lyrics$phi, 
                   theta = Lyrics$theta, 
                   doc.length = Lyrics$doc.length, 
                   vocab = Lyrics$vocab, 
                   term.frequency = Lyrics$term.frequency)


serVis(json, out.dir = 'vis', open.browser = FALSE)



