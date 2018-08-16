#require(tidyverse)
library(ggplot2)
library(reshape2)
library(zoo)

data("AirPassengers")
air <- data.frame(Y=as.matrix(AirPassengers), date=as.Date(as.yearmon(time(AirPassengers))))

p <- ggplot(aes(date, Y), data=air) + 
  geom_line(color='steelblue', size=4)# + geom_area(alpha=0.5, color='steelblue')
