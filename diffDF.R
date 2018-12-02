#diffdf package
#November 28 2018
#EB

#A pacakge for comparing dataframes

library(diffdf)
library(tidyverse)

x<- presidential
x
y<- x
y[10,1]<- "Gore"
y[10,4]<-"Democrat"
y

diffdf(x,y)


y<- head(x, nrow(x)-2)
y
diffdf(x,y)

#what if files are sorted differently?
y<-arrange(x, name)
diffdf(x,y)

#use keys= to specify differntly sorted data
diffdf(x,y, keys = "start")

#get rows with difference
y<- x
y[10,1]<- "Gore"
y[10,4]<-"Democrat"

xyDiff<- diffdf(x,y)
wrongRow<- diffdf_issuerows(y, xyDiff)
wrongRow

RightRow<- diffdf_issuerows(x, xyDiff)
RightRow

y[10,]<- RightRow
y

#sim data
pos<- tibble(ID=LETTERS, val= runif(26))
neg<- pos

#change 3 values
neg[1:3,2]<- neg[1:3,2] * 1.25

#function to check IDs and graph differing values
graphDiff<- function(a,b){
  #check IDs
  idDiff<- diffdf(a[,1], b[,1], keys = "ID", suppress_warnings = TRUE)
  if(diffdf_has_issues(idDiff)) {
    print("inputs dont have same IDs")
  }else{
    #look for values that are different
    valDiff<- diffdf(a,b, keys = "ID", suppress_warnings = TRUE)
    #make tibble of rows that differ
    diffA<- diffdf_issuerows(a,valDiff)
    diffA$treatment<- rep("pos", nrow(diffA))
    diffB<- diffdf_issuerows(b,valDiff)
    diffB$treatment<- rep("neg", nrow(diffB))
    diffBoth<- as.tibble(rbind(diffA,diffB))
    #graph (double bar)
    p1<-ggplot(data=diffBoth, mapping=aes(x=ID, y=val, fill=treatment)) + geom_bar(position = "dodge", stat="identity")
    print(p1)
  }}
graphDiff(pos,neg)
    
  
