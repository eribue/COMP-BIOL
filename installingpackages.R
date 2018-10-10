###Installing packages
#only once
install.packages("")
library("")

####Projects, super useful for organization

#R vs R markdown

#```{r}#chunk
x<-4
x
#Exporting and importing data

library(dplyr)
data("starwars")
starwars1<-select(starwars, name:species)
glimpse(starwars1)
write.table(starwars1, file="Starwarsinfo.csv", row.names = FALSE, sep=",") #creating a csv file from built in data
## option: write.csv()

### read.table() works better when you have metadata
data<-read.table(file = "Filename.csv", row.names = FALSE, header = TRUE, sep= ",", stringsAsFactors = FALSE) #general format
head(data)

starwarsdata<-read.table("Starwarsinfo.csv", header=T, sep = ",", stringsAsFactors = F)
class(starwarsdata)
data<-as_tibble(starwarsdata)
class(data)

#save RDS: useful when working in R; saves a single R object as a file

saveRDS(starwars1, file="starwarstibble")
#readRDS():also reads back in

sw<-readRDS("starwarstibble")
class(sw)

glimpse(sw)

#count NAs
sum(is.na(sw))
sum(!is.na(sw)) #how many are NOT NAs

swSP<-sw %>%
  group_by(species) %>%
  arrange(desc(mass))
swSP

swSP %>%
  summarize(avgmass= mean(mass, na.rm=T), avgheight= mean(height, na.rm = T), n=n())


#filter out low sample sizes

summarize(swSP,avgmass= mean(mass, na.rm=T), avgheight=mean(height, na.rm = T), n=n()) %>%
  filter(n>=2) %>%
  arrange(desc(n))
#using the count helper
swSP %>%
  count(eye_color)

swSP %>%
  count(wt=height) #gives the sum using weight (wt)

#useful summary functions
starwarssumary<-swSP %>%
  summarize(avgHeight= mean(height, na.rm = T), 
            medHeight= median(height, na.rm = T),
            sdHeight= sd(height, na.rm = T), 
            IQRHeight= IQR(height, na.rm = T),
            min_height= min(height, na.rm = T),
            first_height= first(height),
            nth(height,4),
            n_distinct(n_eyecolors=n_distinct(eye_color)),
            n=n()) %>%
  filter(n>=2) %>%
  arrange(desc(n))
starwarssumary

sw2<-sw[complete.cases(sw),] #only include rows that dont have NAs

glimpse(sw2)
#grouping variables
sw2groups<- group_by(sw2, species, hair_color)
summarize(sw2groups, n=n())

sw3<-group_by(sw2, species, hair_color, gender)
summarize(sw3, n=n())

#ungroup

sw3 %>%
  ungroup() %>%
  summarize(n=n())

#grouping with mutate()
###Ex: standardize with 3 groups
sw3<-sw2 %>%
  group_by(species)%>%
  mutate(prop_height=height/sum(height)) %>%
  select(species, height, prop_height)
sw3
sw3 %>%
  arrange(species) #alphabetical order
sw3
