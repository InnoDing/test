#Monte-Carlo Simulations 

# Example 1: When rolling two  independent fair 8-sided dice, 
# what is the probability of their sum to be equal 14? 

M <- 10000
MC <- 1:M 

for (i in 1:M){
  d1 <- sample(1:8, size = 1)
  d2 <- sample(1:8, size = 1)
  MC[i] <- d1 + d2 == 14
}

pest <- sum(MC)/M
p <- 3/64
pest
p

plot(1:M, cumsum(MC) / 1:M - p)
abline(h = 0)


# Example 2: Let X1~N(1,4), X2~N(-1,4), X3~N(0,9). Estimate E(X1+X2-X3)^2 
# and probability that X1+X2-2*X3>0. 

M <- 1000000
MC1 <- 1:M 
MC2 <- 1:M 

for (i in 1:M){
  X1 <- rnorm(1, mean = 1, sd = 2)
  X2 <- rnorm(1, mean = -1, sd = 2)
  X3 <- rnorm(1, mean = 0, sd = 3)
  MC1[i] <- (X1 + X2 - X3)^2
  MC2[i] <- X1 + X2 - 2 * X3 > 0
}

Eest <- mean(MC1)
Eest

pest <- mean(MC2)
pest

# Exercise 1
# The initial price of a Tesla stock is equal to 100$. 
# Lets say that the price of the stock every day grows by 0.5% 
# with probability 0.4, declines by 0.3 % with probability 0.35 
# or remains the same. What is the probability that in 1 year (365 days)
# the price of the stock is going to be higher than 150$.


# Exercise 2
# Simulate a point on a 2 dimensional plane that is chosen uniformly
# in the square with side equal to 2 and center at the beginning of the coordinates. 
# Estimate the probability p that such point falls inside of a unit circle. 
# Calculate 4*p and explain what number it is. 

#sk-b8be09c1847f4220bdd00ef2f5536edc
#8a0f2f9e0051465e8a78e2d9488d20a9.ofwYf8Rqx6NtKH9S



