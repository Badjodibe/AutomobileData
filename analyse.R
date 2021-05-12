library(tidyverse)
library(plyr)
library(gridExtra)

# let us looking at wether there is an averall trend and how the  MPG change over time on average
# in order to do this we use the ddply function in plyr package to automabile data and aggregate row by year and then 
# for each group we compute the mean. we store the resule ( data frame ) into a new variable

mpgbyYr <- ddply(autodata ,~ year , summarise ,avgMPFG = mean(comb08) , avgHghy = mean(highway08) ,avgCity = mean(city08))

#in order to understand this new data frame we performe a time serie plot 

mpgbyYr %>% ggplot(aes(year ,avgMPFG)) + geom_point() + geom_smooth() + ylab("avg MPG") + xlab("year")

#based on this visualization we can think that in the last year there has been a increasing in the fuel economy of cars sold
#however this can be a little mislading as there has been an hybrid and non-gasoline in the last year as shwo below

table(autodata$fuelType1)


#let us look just gasoline cars , and see change


gasCars <- autodata %>% filter(fuelType1 %in% c("Regular Gasoline ","Premium Gasoline","Midgrade Gasoline")  & atvType != "Hybrid")


mpgByYr_gas <- ddply(gasCars , ~ year , summarise , avgMPG  = mean(comb08) )

mpgByYr_gas %>% ggplot(aes(year,avgMPG)) + geom_point() + geom_smooth()


#have fewer engine cars been made recently? if so  this can increase the increase , let us verify that lage engine cars have worse fuel efficiency
#ths displ variable represente  the displacements of the engine


gasCars$displ <- as.numeric(gasCars$displ)

gasCars %>% ggplot(aes(displ , comb08)) + geom_point() + geom_smooth()

#now let us see wether small cars were made the last year which can explain the drastic increase of fuel efficiency

avgCarSize <- ddply(gasCars , ~year , summarise , avgDisp = mean(displ))

avgCarSize %>% ggplot(aes(year ,avgDisp)) + geom_point() + geom_smooth() + xlab("Year") + ylab("Average engine
   displacement (l)")
#from this plot the average displacement has decrease since about 2013 and begin to increase from 2018
#to get better sens that it can have on the fuel efficiency we can plot both displacement and MPG on the same graph


byYear <- ddply(autodata , ~year , summarise , avgDisp = mean(displ) , avgMPG = mean(comb08))

head(byYear)

#we now plot average MPG and average displacement on ths same graph

dis <-  byYear %>% ggplot(aes(year , avgDisp)) + geom_point() + geom_smooth() + ggtitle("displacements average")
mpg <- byYear %>% ggplot(aes(year ,avgMPG )) + geom_point() + geom_smooth() + ggtitle("MPG average")

grid.arrange(dis,mpg , nrow = 2)

#does automatic or manual transmission are more efficiency for four cylinder engine and how the efficiency have change over time


gasCars4 <- gasCars %>% filter(cylinders == "4")

ggplot(gasCars4, aes(factor(year), comb08)) + geom_boxplot() + facet_wrap(~trans2) + theme(axis.text.x = element_text(angle = 45)) + labs(x = "Year", y = "MPG")

gasCars4$trany2 <- ifelse(substr(gasCars4$trany,1,4) == "Auto" , "Auto","Manuel")





