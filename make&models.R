library(tidyverse)

#let us look how make and models inform fuel efficiencey over time

carsMake <- gasCars4 %>% ddply(~year , summarise , numberofMake = length(unique(make)))

#let us see the number of cars make over year

carsMake %>% ggplot(aes(year , numberofMake)) + geom_point() + ggtitle("Four cylindre cars") + ylab("number of make availible") + xlab("year")

#the unique make that have been availible for every year , we apply dlply function to do this

uniqMake <- dlply(gasCars4 ,~year , function(x) unique(x$make))

commonMake <- reduce(intersect , uniqMake)
