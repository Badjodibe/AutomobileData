
#in this file we explore the automabile data set in



library(tidyverse)
load(file = "data/automobile.rda")

 
#our data contain 43550  rows and 83 columns
dim(autodata)


#the datas et year cover 1984 to 2022 with 39 unique year


autodata %>% summarise(min_year = min(year),max_year = max(year) , uniq_year = length(unique(year)) )
 
#now let us find what this of fuel is use as the automobiles' fuel primary type ,we us the table function to counte 
#of each type of fuel

table(autodata$fuelType1)

# from this code output we see that most cars use Regular Gasoline and the second type of fuel commonly use is Premium Gasiline


#let us explore the type of transmission use by  these automobile , by first puing missing value to NA
#we omly want the Auto or Manuel transmission so we use the if else function to performe that and store the result inn trans2 varible

autodata$trany[autodata$trany == ""] <- NA

autodata$trans2 <- ifelse(substr(autodata$trany , 1 ,4) == "Auto" , "Auto","Manuel")

#finaly let us see the distribution of these value

table(autodata$trans2)

#most vehicle in the data set us Automatic transmission

with(autodata , table(sCharger , year))
with(autodata , table(tCharger , year))
