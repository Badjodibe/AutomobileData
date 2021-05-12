library(tidyverse)
library(downloader)

#downloads the file contain the data and its description on the internet


url1 <- "http://www.fueleconomy.gov/feg/epadata/vehicles.csv.zip"


zfile <- download(url = url1 , destfile = "vehicles.csv.zip")

#read the file

autodata <- read_csv(file = "vehicles.csv")
save(autodata , file = "data/automobile.rda")
