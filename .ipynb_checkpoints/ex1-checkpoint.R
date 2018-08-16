library('ggplot2')
library(reshape2)
#air <- read.csv('data/international-airline-passengers.csv', stringsAsFactors = FALSE)
data("AirPassengers")
AP <- AirPassengers
#air$Month <- as.Date(as.yearmon(air2$Month))
#air$Month <- as.factor(air$Month)
#air$Month <- strftime(air$Month, format="%Y-%m")
#air$Month <- as.Date(air$Month, format="%Y-%m")
#print(summary(air))
#m <- ggplot(aes(Month, a, group=1), data=air) + geom_line() + geom_smooth()

plot(AP, ylab="Passengers (1000s)", type="o", pch =20)

# Decompose
AP.decompM <- decompose(AP, type = "multiplicative")
plot(AP.decompM)

# Trend component
t <- seq(1, 144, 1)
modelTrend <- lm(formula = AP.decompM$trend ~ t)
predT <- predict.lm(modelTrend, newdata = data.frame(t))

plot(AP.decompM$trend[7:138] ~ t[7:138], ylab="T(t)", xlab="t",
     type="p", pch=20, main = "Trend Component: Modelled vs Observed")
lines(predT, col="red")


#layout(matrix(c(1,2,3,4),2,2))
#plot(modelTrend)

# Trend
summary(modelTrend)
Data1961 <- data.frame("T" = 2.667*seq(145, 156, 1) + 84.648, S=rep(0,12), e=rep(0,12),
                       row.names = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))
Data1961

Data1961$S <- unique(AP.decompM$seasonal)
Data1961

plot(density(AP.decompM$random[7:138]),
     main="Random Error")
     
mean(AP.decompM$random[7:138])

Data1961$e <- 1
Data1961


#### Predictions
sd_error <- sd(AP.decompM$random[7:138])
sd_error

# Generate new data
Data1961$R <- Data1961$T * Data1961$S * Data1961$e                  #Realistic Estimation
Data1961$O <- Data1961$T * Data1961$S * (Data1961$e+1.95*sd_error)  #Optimistic Estimation
Data1961$P <- Data1961$T * Data1961$S * (Data1961$e-1.95*sd_error)  #Pessimistic Estimation
Data1961

xr = c(1,156)
plot(AP.decompM$x, xlim=xr, ylab = "Passengers (100s)", xlab = "Month")
lines(data.frame(AP.decompM$x))
lines(Data1961$R, x=seq(145,156,1), col="blue")
lines(Data1961$O, x=seq(145,156,1), col="green")
lines(Data1961$P, x=seq(145,156,1), col="red")