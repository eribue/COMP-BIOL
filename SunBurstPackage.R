#Sunburst is a great way to summarize and view observational data not based on numbers but letters and words

library(ggplot2)
library(sunburstR)
library(dplyr)
library(magrittr)

data<- read.csv("sunburstData.csv", header=TRUE, colClasses=c("interger","charecter"))

action<- data %>%
  group_by(Time_tag) %>%
  filter(row_number()==1 %>%
           ungroup() %>%
           summarize(Response=paste(c(Response), collapse="-"))
         )

sequences<- action %>%
  ungroup() %>%
  group_by(Response) %>%
  summarize(count=n())

sequences$depth<- unlist(lapply(strsplit(sequences$Response, "-", length))
                         
#lapply returns a list of the same length of x so we worked with our times before now we are working with our responses
#str split splits the elements of our charecter vector into substrings

sb<- sequences %>%
  arrange(desc(depth), Response) %>%
  sunburst(count=TRUE)
print(sb)

#the 8 in the center means there are 8 diff combinations of observations in our data 

