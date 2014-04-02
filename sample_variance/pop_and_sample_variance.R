library(ggplot2)
library(reshape2)
library(ggthemes)

# Population size = 100000
N <- 100000

# Generate a population of a 100000 uniform random values
pop <- runif(N)

# Calculate the population mean
pop.mean <- mean(pop)

# Calculate the population variance
pop.var <- sum((pop - pop.mean)^2)/N

# Number of samples = 100
K <- 10000

# Sample size = 50
n <- 50

# List to store the sample mean and variance
samp.mean <- NULL
samp.var.biased <- NULL
samp.var.unbiased <- NULL

# Loop over the samples
for (i in 1:K) {
  # Choose a random sample
  samp <- sample(pop, n)
  
  # Calculate and store the sample mean
  s_mean <- mean(samp)
  samp.mean <- c(samp.mean, s_mean)
  
  # Calculate and store the *biased* sample variance
  samp.var.biased <- c(samp.var.biased, (sum((samp - s_mean)^2)/n))

  # Calculate and store the *biased* sample variance
  samp.var.unbiased <- c(samp.var.unbiased, (sum((samp - s_mean)^2)/(n-1)))
}

# Plot the biased and unbiased variance estimates
df <- data.frame(index = c(1:K),
                 pop = rep(pop.var, K),
                 biased = samp.var.biased,
                 unbiased = samp.var.unbiased)
df.melted <- (melt(df, id=c("index", "pop")))

ggplot(data = df.melted, aes(x = index, y = value, colour=variable)) +
  geom_point() +
  theme_few() + scale_colour_few() +
  geom_point(aes(y = pop), col="blue") +
  ggtitle("Biased and Unbiased estimators of Population variance") +
  xlab("Iteration") +
  ylab("Estimated Variance")
  
# Percentage of times 'unbiased' is equal or better estimator of the pop variance
(sum(abs(samp.var.unbiased - pop.var) <= abs(samp.var.biased - pop.var)) / K) * 100
