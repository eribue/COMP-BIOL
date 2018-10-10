### Manipulating Data using dplyr
### Start with a built in dataset
install.packages("dplyr")
library(dplyr)
data(starwars) #open built in dataframe
class(starwars) #type is tibble
glimpse(starwars) #better than str in this case
head(starwars)

##clean up our data
starwarsClean<-starwars[complete.cases(starwars [1:10]),] #removes NAs from rows 1:10
print(starwarsClean)
#check for NAs
is.na(starwarsClean)
anyNA(starwarsClean)
anyNA(starwars)

#filter()
#lets you pick or subset observations based on their values
#uses > >= < <= != ==
#logical operators & | !

filter(starwarsClean, gender=="male", height <180) #automatically excludes NAs unless you specifically ask for them but other rows can include NAs
filter(starwarsClean, eye_color %in% c("blue", "brown"))
filter(starwarsClean, gender=="male", height <180, height >100) #you can add multiple conditions

# arrange() reorders rows
arrange(starwarsClean, height) #arranges coloumn height by acscending heights
arrange(starwarsClean, desc(height))
#break ties by putting more columns
arrange(starwarsClean, height, desc(mass))
starwars1<-arrange(starwars, height)
tail(starwars1) #all NAs at the bottom

#select() choose variables by their name
glimpse(starwarsClean)
starwarsClean[1:10,]
select(starwarsClean, 1:10)
select(starwarsClean, name:species)
select(starwarsClean, -(films:starships)) #- means all except
select(starwarsClean, -(c(name & height)))
#moving column around
select(starwarsClean, name, gender, species, everything()) #everthing function means everything else after
select(starwarsClean, contains("color")) #contains the word color
#other helper functions: ends_with, starts_with, matches(regular expressions), num_range

#rename colums with select()
select(starwars, haircolor=hair_color) #not very helpful
rename(starwarsClean, haircolor=hair_color)

#mutate() create new variables with functions of existing variables
mutate(starwarsClean, ratio=height/mass) #arithmetic operators
glimpse(starwarsClean)

starpounds<-mutate(starwarsClean, mass_lbs= mass * 2.2)
head(starpounds)
select(starpounds, name:mass, mass_lbs, everything())

transmute(starwarsClean, mass_lbs=mass*2.2) #only returns new variable

#summarize() and group_by()
summarize(starwarsClean, meanHeight=mean(height))

#group_by for more usefulness
starGender<- group_by(starwars, gender)
summarize(starGender, meanHeight= mean(height, na.rm=TRUE, Totalnumber=n())) #na.rm removes NAs #n() returns sample size

#summarize groups via piping
starwarsClean %>%
  group_by(gender)%>%
  summarize(meanHeight=mean(height, na.rm = TRUE), Totalnumber=n())
dataclean<- complete.cases[dataframe[,1:20]]

  
