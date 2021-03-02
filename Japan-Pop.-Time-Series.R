
# Tyler Edwards
# 12 - 9 - 2019

# Japan Population Time Series Analysis

# --------------------------------------------------------------------------------

# 0.0.] Creating and cleaning data

Raw = read.csv("Japan_population_data.csv")
A = aggregate(. ~ year, data=Raw, FUN=sum)
B = data.frame(A$year, A$population) # Only needed variables
colnames(B) = c("Year", "Population")

Y = B[0:44,]
colnames(Y) = c("Year", "Population")

X = data.frame("Year" = 1960:2018, "Population" = c( 
      92500572,	94943000,	95832000,	96812000,	97826000,	
      98883000,	99790000,	100725000,	101061000,	103172000,	
      104345000,	105697000,	107188000,	108079000,	110162000,	
      111940000,	112771000,	113863000,	114898000,	115870000,	
      116782000,	117648000,	118449000,	119259000,	120018000,	
      120754000,	121492000,	122091000,	122613000,	123116000,	
      123537000,	123921000,	124229000,	124536000,	124961000,	
      125439000,	125757000,	126057000,	126400000,	126631000,	
      126843000,	127149000,	127445000,	127718000,	127761000,	
      127773000,	127854000,	128001000,	128063000,	128047000,	
      128070000,	127833000,	127629000,	127445000,	127276000,	
      127141000,	126994511,	126785797,	126529100 ) )

Clean = rbind(Y,X)

library("readxl")
Clean2 = read_excel("Japan Population (CLEAN).xlsx")
str(Clean2)

JP = ts(Clean2, start = 1872, frequency = 1)
plot(JP, main = "Japan Population Over Time", ylab = "Population", xlab = "Years")

Train = ts(JP[1:128], start = 1872, frequency = 1)
plot(Train, type = "l", main = "Japan Population Over Time (Train)", ylab = "Train Poulation", xlab = "Years")

Test = ts(JP[129:147], start = 2000, frequency = 1)
plot(Test, type = "l", main = "Japan Population Over Time (Test)", ylab = "Test Poulation", xlab = "Years")

plot(diff(Train), main = "Japan Population Difference Over Time (Train)") # Not very linear

plot(log(Train)) # Not much different

plot(diff(log(Train)))

# --------------------------------------------------------------------------------

# 1.0.] Selecting a model

ar(Train) # AR(1)
acf(Train ,ci.type='ma',xaxp=c(0,20,10), main = "Train ACF")
acf(Train, 50, main = "Train ACF") # Diminishing to zero (AR(p))

pacf(Train, 100) # Starts high then hovers around 0 (AR(p))
pacf(Train, 5, main = "Train PACF") # Equals zero past 1 (AR(1))

library(fUnitRoots) 
adfTest(Train ,lags=1,type='c')
adfTest(Train ,lags=1,type='ct')

library(TSA)
eacf(Train) # Maybe ARMA(1,2)

plot(ARMAacf(Train, lag.max = 50)) 

# AR(1) model chosen

# --------------------------------------------------------------------------------

# 2.0.] Estimating parameters

ar(Train,order.max=1,aic=F,method='yw') # 0.9788
ar(Train,order.max=1,aic=F,method='ols') # 0.9936
# ar(Train,order.max=1,aic=F,method='mle') # Doesn't work

# arima(Train ,order=c(1,0,0) ,method='CSS') # 1.0096
arima(Train ,order=c(1,0,0) ,method='ML')  # 0.9998
# Average of all estimates = 0.99535

# --------------------------------------------------------------------------------

# 3.0.] Checking model

TrainR = arima(Train ,order =c (1,0,0))
TrainR
plot(rstandard(TrainR))
abline(h=0)

qqnorm(residuals(TrainR), main = "Train Q-Q Plot")
qqline(residuals(TrainR))
shapiro.test(residuals(TrainR)) # P-value < .01
# Residual are a normal distribution

acf(residuals(TrainR), 50, main = "Train ACF") # Alternating and diminishing to 0
                            # Values are close to 0, there's somewhat of a pattern
tsdiag(TrainR,gof=15,omit.initial=F) 
# P-value < .05 so the residuals are dependent
runs(residuals(TrainR))
# Residuals are dependent

# Failed 3 out of 5 tests
# Assumed AR(1) is the wrong model


# --------------------------------------------------------------------------------

# 1.1.] Reselecting a model

# Interpreted Dickey-Fuller test wrong
adfTest(Train ,lags=1,type='c')
adfTest(Train ,lags=1,type='ct')
# P-value > .05 = needs to be differenced

TrainA = log(Train)
plot(TrainA) # Same as without the log

TrainB = diff(Train)
plot(TrainB)

adfTest(TrainB ,lags=1,type='c')
adfTest(TrainB ,lags=1,type='ct')
# P-values < .01

acf(TrainB ,xaxp=c(0,20,10))
pacf(TrainB ,xaxp=c(0,20,10))

# library(forecast)
# auto.arima(Train) # ARIMA(0,2,2) 

TrainC = diff(TrainB)
plot(TrainC) # Not very linear

acf(TrainC ,xaxp=c(0,20,10))
pacf(TrainC ,xaxp=c(0,50,10), 50) # Diminishing to 0
eacf(TrainC) # Unclear

# 2.1.] Estimating parameters

arima(Train ,order=c(0,2,2) ,method='CSS') # -0.4931, -0.3195
arima(Train ,order=c(0,2,2),method='ML')   # -0.4878, -0.3138

# 3.1.] Checking model

TrainCR = arima(Train ,order =c (2,1,2))
TrainCR
plot(rstandard(TrainCR))
abline(h=0)

qqnorm(residuals(TrainCR))
qqline(residuals(TrainCR))
shapiro.test(residuals(TrainCR)) # P-value < .01
# Residual are a normal distribution

acf(residuals(TrainCR), 100) # Randomly alternating and diminishing to 0, only one value significanly > 0.

tsdiag(TrainCR,gof=15,omit.initial=F) 
# P-value > .05 so the residuals are independent
runs(residuals(TrainCR))
# Residuals are independent

# All tests passed, selecting ARIMA(0,2,2)

# --------------------------------------------------------------------------------

# 4.0.] Forecasting

M1 = lm(TrainC ~ time(TrainC))
summary(M1) # Very low R^2 (below .001)
plot(residuals(M1)) 

M2 = lm(Train ~ time(Train))
summary(M2) # R^2 is 9.466
plot(residuals(M2), main = "AR(1) Residuals")

# First AR(1) model fits better


par(mfrow=c(1,2))
plot(TrainR, n.ahead = 19, type = "p", ylab = "Population", main = "Predicted")
plot(JP, type = "p", main = "Actual")

plot(TrainR, n.ahead = 19, xlim = c(1980,2018), type = "p", ylab = "Population", main = "Predicted (1980-2018)")
plot(JP, xlim = c(1980,2018), type = "p", main = "Actual (1980 - 2018)")

par(mfrow=c(1,1))
plot(TrainR, n.ahead = 66, type = "p", ylab = "Population", main = "Predicted (1872 - 2065)")

