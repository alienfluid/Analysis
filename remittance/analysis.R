# Load the required libraries
library(ggplot2)
library(zoo)
library(gridExtra)

# Read in the monthly remittance data for Mexico
remit <- read.table('data/mexico.txt')

# Generate the months from Jan 2003 - Oct 2013
months <- seq(from = as.Date('2003-01-01'), to = as.Date('2013-10-01'), by = 'months')

# Put it together in a data frame
df <- data.frame(remit = remit[,1], month = months)

# Quick plot of the relationship
p1 <- ggplot(data = df, aes(x = month, y = remit)) + 
  geom_line() + 
  geom_point() + 
  xlab("Month") +
  ylab("Remittance in USD (Millions)") +
  ggtitle("Monthly remittance inflow - Mexico") +
  theme_bw()

# Read in the exchange rate data
xr <- read.csv('data/USDMXN.csv')

# Align the dates to the beginning of the month and set the correct class for the data
xr$Date <- as.Date(as.yearmon(as.Date(xr$Date) + 1))

# Plot everything together
p2 <- ggplot(data = xr, aes(x = Date, y = USD.MXN)) + 
  geom_line() + 
  geom_point() +
  xlab("Month") +
  ylab("MXN / 1 USD") +
  ggtitle("USD/MXN Exchange Rate") +
  theme_bw()

# Plot together
grid.arrange(p1, p2)

# Regress remittance on exchange rate
md <- lm(df$remit ~ xr$USD.MXN)
summary(md)