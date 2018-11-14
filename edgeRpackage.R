#-------------------Download, install, and open edgeR pacakge-----------------
source("http://bioconductor.org/biocLite.R")
biocLite("edgeR")
library(edgeR)

source("http://bioconductor.org/biocLite.R")
biocLite("baySeq") #dataset is built in to bayseq

#data set is a matrix (mobData) of counts acquired for three thousand small RNA loci from a set of Arabidopsis grafting experiments

library(baySeq)
#Loading the data set
load("mobData.RData")
head(mobData) #A matrix of which each of the six columns represents a sample, and each row an sRNA locus (acquired by sequencing).

help("mobData") #help function provides more info about the dataset

#--------------Preparing the dataset ready for edgeR pacakage----------------
mobDataGroups <- c("MM", "MM", "WM", "WM", "WW", "WW") #making a vector for mutant groups
# MM="triple mutatnt shoot grafted onto triple mutant root"
# WM="wild-type shoot grafted onto triple mutant root"
# WW="wild-type shoot grafted onto wild-type root"

data(mobAnnotation)
help("mobAnnotation") #data frame describing the start and end of (3000) sRNA loci (chromosome position of sRNA loci)
head(mobAnnotation)
tail(mobAnnotation)

##edgeR works on a table of integer read counts, with rows corresponding to genes and columns to independent libraries. edgeR stores data in a simple list-based data object called a DGEList. This type of object is easy to use because it can be manipulated like any list in R. You can make this in R by specifying the counts and the groups in the function DGEList().

d <- DGEList(counts=mobData,group=factor(mobDataGroups))
d

#-------------------------Filtering the data---------------------------------
dim(d)
d.full <- d #keeping a copy of d

head(cpm(d)) #function cpm(): calculates counts per million; we will use to this to filter out genes with cpms less than 100
d$counts
apply(d$counts, 2, sum) # calculating the total no. of gene counts per sample

keep <- rowSums(cpm(d)>100) >= 2 #selecing genes with cpm>100 for at least 2 samples, will give a TRUE if criteria is met for each gene
d <- d[keep,] #selecting from d; only those genes that met the criteria
dim(d) #no. of counts reduced to 724

d$samples$lib.size <- colSums(d$counts) #changing the lib.size to match the filtered data
d$samples 

#----------------------------Normalizing the data---------------------------
#Explain importance of normalizing RNAseq data and how edgeR uses an effective lib size to normalize
d <- calcNormFactors(d) #adds new element to norm.factors: mean of M-values (TMM) between each pair of samples (look up what this means)
d

#----------------------------Data Exploration-------------------------------
#Plotting groups based on distances between groups
#PlotMDS; Multidimensional scaling plot of distances bw gene expression profiles
plotMDS(d, method="bcv", col=as.numeric(d$samples$group)) #what is bcv? ) calculates distances based on biological coefficient of variation- what this means is... 
legend("bottomleft", as.character(unique(d$samples$group)), col=1:3, pch=20)

#----------------------------Estimating dispersion---------------------------
d1 <- estimateCommonDisp(d, verbose=T)




