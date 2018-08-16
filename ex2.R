library(ggplot2)

sbux.df = read.csv("data/sbuxPrices.csv", header = TRUE, stringsAsFactors = FALSE) 


sbux.ts = ts(data=sbux.df$Adj.Close, frequency = 12,
             start=c(1993,3), end=c(2008,3)) 
