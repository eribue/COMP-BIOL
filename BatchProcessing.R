#Script for batch processing

#function: Filebuilder
#creates a set of random files for regressin
#input fileN= no. of files to create
#filefolfer= name of folfer to hold files
#file size<- c(min, max)
#fileNA= avg no of values per column 
#output= set of random files

#__________________________________________________________________________________________
fileBuilder<- function (fileN=10,
                        fileFolder="RandomFiles/",
                        fileSize=c(15,100),
                        fileNA=3)
  {
  for (i in seq_len(fileN)){
    filelength<- sample(fileSize[1]:fileSize[2], size = 1)
    varx= runif(filelength)
    vary<-runif(filelength)
    dF<- data.frame(varx, vary)
    badVals<- rpois(n=1, lambda =fileNA)
    dF[sample(nrow(dF),size=badVals, 1)]<-NA
    dF[sample(nrow(dF),size=badVals,2)]<-NA
    #create label for file name with padded zeros
    fileLabel<- paste(fileFolder,
                      "ranFile",
                      formatC(i, 
                              width = 3,
                              format = "d",
                              flag = "0"),
                              ".csv", sep="")
    #set up data file and incorporate time stamp
    #and some minimal metadata
    write.table(cat("# simulated random data file for batch processing", "\n",
                    "# timestamp: ", as.character(Sys.time()), "\n",
                    "\n",
                    file=fileLabel,
                    row.names="",
                    col.names<-"",
                    sep=""),
write.table(x=dF,
            file =fileLabel,
            sep=",",
            row.names=FALSE,
            append= TRUE))
          }
}


###############################################################################################
#function: regStats
#fits linear model extracts data frame ( x and y)
#input: 2-column data frame
#output: slope, pvalue, and r2


regStats<- function(d=NULL){
  if(is.null(d)){
    xvar<- runif(10)
    yvar<- runif(10)
    d<- data.frame(xvar, yvar)
  }
.<- lm(data=d, d[,2]~d[,1])
.<- summary(.)
statslist<- list(Slope=.$coefficients[2,1],
                 pval=.$coefficients[2,4],
                 r2<-.$r.squared)
return(statslist)
}
regStats()

######################################################################################################

#set.seed(100)
------------------------------------------------------------------------
#global variables
  
fileFolder<- "RandomFiles/"
nFiles<- 100
fileOut<- "StatsSummary.csv"
------------------------------------------------------------------------
#create 100 random datasets
fileBuilder(fileN=nFiles)
#create a large vector filenames
fileNames<- list.files(path=fileFolder)
head(fileNames)
#create data frame for summary statistics
ID<- seq_along(fileNames)
slope<- rep(NA, nFiles)
pval<- rep(NA, nFiles)
r2<- rep(NA, nFiles)
stats.out<- data.frame(ID,fileNames, slope, pval, r2)
head(stats.out)

#batch process through each file with a loop
for (i in seq_along(fileNames)){
  data<- read.table(file=paste(fileFolder, fileNames[i], sep=""),
                    sep=",", 
                    header = TRUE)
  dClean<-data[complete.cases(data), ] #strips out NA
  .<- regStats(dClean)
  statsout[i,3:5]<- unlist(.)
}

#set up output file and incorporate time stamp and min metadata
write.table(cat("# Summary stats for",
                "#batch processing of regression models",
                "\n",
                "timestamp:", as.character(Sys.time()), "\n",
                "NJG", "\n",
                "#---------------------------", "\n",
                "\n",
                file = fileOut,
                row.names="",
                col.names="",
                sep=""))
#now add the data frame
write.table(x=statsout,
            file= fileOut,
            row.names=FALSE,
            append = TRUE)
  
                    





