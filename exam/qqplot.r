X <- c(5, 3, 6, 7, 5, 6, 5, 5, 4, 3, 6, 7, 5, 5, 6, 5, 5, 5, 1, 7, 
       3, 5, 7, 7, 7, 6, 7, 2, 5, 5, 2, 6, 5, 2, 5, 6, 5, 6, 6, 3, 
       6, 5, 6, 6, 6, 5, 6, 2, 5, 5, 7, 5, 7, 5, 3, 4, 1, 2, 5, 5)

# sorted observations, i.e., empirical quartiles
empirical_q <- sort(X)

n <- length(X)

# Corresponding quantile
pvec <- (1:n) / (n + 1)

# Theoretical quantile of the binomial distribution
theoretical_q <- qbinom(pvec, size = 7, prob = 9/14)

# plot
plot(theoretical_q, empirical_q,
     xlab = "Theoretical Quantiles (Binomial(7, 9/14))",
     ylab = "Empirical Quantiles (data)",
     main = "Q-Q Plot: Data vs. Binomial(7, 9/14)",
     pch  = 19, col = "blue")
abline(0, 1, col = "red", lwd = 2)