require(igraph) 

edgelist<-read.delim('/Users/ackman/Documents/MATLAB/dCorrpairs-20131105-125023.txt')

edgelist2<-subset(edgelist,rvalue > 0.1)


g <- graph.data.frame(edgelist2, directed=FALSE)
#V(g)$label <- V(g)$name  #gets the actual vertice labels
plot(g,layout=layout.lgl,vertex.size=5)
title('layoutLgl, vertex size5')

quartz();
plot(g, layout=layout.fruchterman.reingold, vertex.size=3)
title('layoutFR, vertex size3')

quartz();
com <- spinglass.community(g, spins=5)   #finds communities
V(g)$color <- com$membership+1
plot(g, layout=layout.fruchterman.reingold)
title('spinglass, layoutFR, default vertex size')


walktrapCom<-walktrap.community(g)
V(g)$color <- walktrapCom$membership+1

quartz();
palette(rainbow(max(V(g)$color),alpha=0.5))
plot(g, layout=layout.fruchterman.reingold)
palette("default")
title('walktrap, layoutFR, default vertex size,alpha0.5')


quartz();
palette(rainbow(max(V(g)$color),alpha=0.5))
plot(g, layout=layout.lgl)
palette("default")
title('walktrap, layoutLgl, default vertex size,alpha0.5')


quartz();
palette(rainbow(max(V(g)$color),alpha=0.5))
plot(g, layout=layout.kamada.kawai)
palette("default")
title('walktrap, layout.kamada.kawai, default vertex size,alpha0.5')

g <- graph.data.frame(edgelist2, directed=FALSE)
fastgreedyCom<-fastgreedy.community(g)
V(g)$color <- fastgreedyCom$membership+1
quartz();
palette(rainbow(max(V(g)$color),alpha=0.5))
plot(g, layout=layout.kamada.kawai)
palette("default")
title('fastgreedy, layout.kamada.kawai, default vertex size,alpha0.5')




edgelist2<-subset(edgelist,rvalue > 0.1)
g <- graph.data.frame(edgelist2, directed=FALSE)
fastgreedyCom<-fastgreedy.community(g)
V(g)$color <- fastgreedyCom$membership+1
quartz();
palette(rainbow(max(V(g)$color),alpha=0.5))
plot(g, layout=layout.fruchterman.reingold)
palette("default")
title('fastgreedy, layout.fruchterman.reingold, default vertex size,alpha0.5')




# Edgelist > 0.2

edgelist2<-subset(edgelist,rvalue > 0.2)
g <- graph.data.frame(edgelist2, directed=FALSE)
fastgreedyCom<-fastgreedy.community(g)
V(g)$color <- fastgreedyCom$membership+1
quartz();
palette(rainbow(max(V(g)$color),alpha=0.5))
plot(g, layout=layout.fruchterman.reingold)
palette("default")
title('fastgreedy, layout.fruchterman.reingold, rvalue >0.2')


degree(g)
degree.distribution(g)
degree.distribution(g,cumulative = TRUE)




#------Histogram of degree distribution-------------------------------------------------------------
df <- data.frame(degree(g))
colnames(df) <- c("degree")
p <- ggplot(df, aes(x=degree)) + xlab("degree") + theme_bw()
p + geom_histogram(binwidth = 2) + scale_colour_brewer(palette="Set1") + opts(aspect.ratio=1)  #raw counts
ggsave(file=paste("120518_07-degreeDist", format(Sys.time(),"%y%m%d-%H%M%S"), ".pdf",sep=""))






# 2014-01-07 09:07:59


edgelist<-read.delim('/Users/ackman/Data/2photon/120518i/2014-01-03-231550/dCorr.txt')
# d2 <- subset(edgelist,filename!='120518_09.tif')

rthresh <- 0.2
fnm <- '120518_07'
fnm2 <- paste(fnm,".tif",sep="")
lo <- 'layout.fruchterman.reingold'
# lo <- 'layout.kamada.kawai'
# lo <- 'layout.lgl'
d3 <- subset(edgelist,filename==fnm2)
d4 <- with(d3,data.frame(node1,node2,rvalue))
edgelist2<-subset(d4,rvalue > rthresh)
g <- graph.data.frame(edgelist2, directed=FALSE)
E(g)$weight <- E(g)$rvalue
E(g)$width <- 1
E(g)[ weight >= 0.3 ]$width <- 3
E(g)[ weight >= 0.5 ]$width <- 5
fastgreedyCom<-fastgreedy.community(g,weights=E(g)$weight)
V(g)$color <- fastgreedyCom$membership
# quartz();
# palette(rainbow(max(V(g)$color),alpha=0.5))
mypalette <- adjustcolor(brewer.pal(max(V(g)$color),"Set1"),0.6)
palette(mypalette)
plot(g, layout=eval(parse(text=lo)), edge.width=E(g)$width, edge.color="black", vertex.label.color="black")
# palette("default")
title(paste(fnm,', fastgreedy default, ', lo, 'r>', rthresh))
dateStr=format(Sys.time(),"%y%m%d-%H%M%S")
quartz.save(file=paste(dateStr, "-", fnm,  ".png",sep=""), type = "png", dpi=150)
quartz.save(file=paste(dateStr, "-", fnm,  ".pdf",sep=""), type = "pdf")



# 131208


edgelist<-read.delim('/Users/ackman/Data/2photon/131208/2014-01-07-003602/dCorr.txt')

rthresh <- 0.2
fnm <- '131208_09'
fnm2 <- paste(fnm,".tif",sep="")
lo <- 'layout.fruchterman.reingold'
# lo <- 'layout.kamada.kawai'
# lo <- 'layout.lgl'
d3 <- subset(edgelist,filename==fnm2)
d4 <- with(d3,data.frame(node1,node2,rvalue))
edgelist2<-subset(d4,rvalue > rthresh)
g <- graph.data.frame(edgelist2, directed=FALSE)
E(g)$weight <- E(g)$rvalue
E(g)$width <- 1
E(g)[ weight >= 0.3 ]$width <- 3
E(g)[ weight >= 0.5 ]$width <- 5
fastgreedyCom<-fastgreedy.community(g,weights=E(g)$weight)
V(g)$color <- fastgreedyCom$membership
# quartz();
# palette(rainbow(max(V(g)$color),alpha=0.5))
mypalette <- adjustcolor(brewer.pal(max(V(g)$color),"Set1"),0.6)
palette(mypalette)
plot(g, layout=eval(parse(text=lo)), edge.width=E(g)$width, edge.color="black", vertex.label.color="black")
# palette("default")
title(paste(fnm,', fastgreedy default, ', lo, 'r>', rthresh))
dateStr=format(Sys.time(),"%y%m%d-%H%M%S")
quartz.save(file=paste(dateStr, "-", fnm,  ".png",sep=""), type = "png", dpi=150)
quartz.save(file=paste(dateStr, "-", fnm,  ".pdf",sep=""), type = "pdf")



# 2014-01-14 14:59:18 Make mean summary graphs for P3 and P8

edgelist<-read.delim('/Users/ackman/Data/2photon/131208/2014-01-07-003602/dCorr.txt')
edgelist<-read.delim('/Users/ackman/Data/2photon/120518i/2014-01-03-231550/dCorr.txt')


library(plyr)
library(igraph)
library(RColorBrewer)

d2 <- ddply(edgelist, c("node1","node2"), summarize,
rvalue.mean = mean(rvalue),
rvalue.sd = sd(rvalue), 
N = length(rvalue), 
rvalue.sem = rvalue.sd/sqrt(N))
colnames(d2)[colnames(d2) == 'rvalue.mean'] <- 'rvalue'

rthresh <- 0.15
fnm <- 'P8'
# fnm2 <- paste(fnm,".tif",sep="")
lo <- 'layout.fruchterman.reingold'
# lo <- 'layout.kamada.kawai'
# lo <- 'layout.lgl'
# d3 <- subset(edgelist,filename==fnm2)
# d4 <- with(d3,data.frame(node1,node2,rvalue))
edgelist2<-subset(d2,rvalue > rthresh)
g <- graph.data.frame(edgelist2, directed=FALSE)
E(g)$weight <- E(g)$rvalue
E(g)$width <- 1
E(g)[ weight >= 0.3 ]$width <- 3
E(g)[ weight >= 0.5 ]$width <- 5
fastgreedyCom<-fastgreedy.community(g,weights=E(g)$weight)
V(g)$color <- fastgreedyCom$membership
quartz();
# palette(rainbow(max(V(g)$color),alpha=0.5))
mypalette <- adjustcolor(brewer.pal(max(V(g)$color),"Set1"),0.6)
palette(mypalette)
plot(g, layout=eval(parse(text=lo)), edge.width=E(g)$width, edge.color="black", vertex.label.color="black")
# palette("default")
title(paste(fnm,', fastgreedy default, ', lo, 'r>', rthresh))
dateStr=format(Sys.time(),"%y%m%d-%H%M%S")
quartz.save(file=paste(dateStr, "-", fnm,  ".png",sep=""), type = "png", dpi=150)
quartz.save(file=paste(dateStr, "-", fnm,  ".pdf",sep=""), type = "pdf")


print(fastgreedyCom)
degree(g)
degree.distribution(g)
degree.distribution(g,cumulative = TRUE)
average.path.length(g) 
diameter(g)
hub.score(g)$vector
mean(degree(g))

#------Histogram of degree distribution-------------------------------------------------------------
df <- data.frame(degree(g))
colnames(df) <- c("degree")
p <- ggplot(df, aes(x=degree)) + xlab("degree") + theme_bw()
p + geom_histogram(binwidth = 2) + scale_colour_brewer(palette="Set1") + opts(aspect.ratio=1)  #raw counts
dateStr=format(Sys.time(),"%y%m%d-%H%M%S")
ggsave(file=paste(dateStr, "-degreeDist-", fnm,  ".pdf",sep=""))


# This should approximately yield the correct exponent 3
# g <- barabasi.game(1000) # increase this number to have a better estimate
# d <- degree(g, mode="in")
d <- degree(g)
fit1 <- power.law.fit(d,3)
fit2 <- power.law.fit(d,3, implementation="R.mle")

fit1$alpha
coef(fit2)
fit1$logLik
logLik(fit2)







# Sample power law dynamics

# This should approximately yield the correct exponent 3
g <- barabasi.game(1000) # increase this number to have a better estimate
d <- degree(g, mode="in")
fit1 <- power.law.fit(d+1, 10)
fit2 <- power.law.fit(d+1, 10, implementation="R.mle")

fit1$alpha
coef(fit2)
fit1$logLik
logLik(fit2)

df <- data.frame(degree(g))
colnames(df) <- c("degree")
p <- ggplot(df, aes(x=degree)) + xlab("degree") + theme_bw()
p + geom_histogram(binwidth = 2) + scale_colour_brewer(palette="Set1") + opts(aspect.ratio=1)  #raw counts
dateStr=format(Sys.time(),"%y%m%d-%H%M%S")
title("barabasi.game(33), powerlaw")
ggsave(file=paste(dateStr, "-degreeDist-", "barabasiGame-powerlaw",  ".pdf",sep=""))


g <- graph.ring(10)
E(g)$weight <- runif(ecount(g))
E(g)$width <- 1
E(g)[ weight >= 0.5 ]$width <- 3
plot(g, layout=layout.circle, edge.width=E(g)$width, edge.color="black")
  

