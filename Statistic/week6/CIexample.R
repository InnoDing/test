ciexample <- function() {  
  # unknown
  mu <- runif(1, min=-1e6, max=1e6)
  
  # sometimes assumed known
  sigma <- rexp(1, rate=.1)
  
  # sample n observations
  n <- round(2 + rexp(1, rate=.1))
  sample <- rnorm(n, mean=mu, sd=sigma)
  
  # estimate mean
  muhat <- mean(sample)
  
  # construct 95% confidence interval
  lower <- muhat - qnorm(.975) * sigma / sqrt(n)
  upper <- muhat + qnorm(.975) * sigma / sqrt(n)
  
  # if we had to estimate sigma,
  # the Gaussian CI using sigmahat would no longer be accurate,
  # but we know it can be fixed...
  # the below assumes a Gaussian instead of a t distribution,
  # so is not a valid CI interval for the case that sigma is unknown
  # sigmahat <- sd(sample)
  # lower <- muhat - qnorm(.975) * sigmahat / sqrt(n)
  # upper <- muhat + qnorm(.975) * sigmahat / sqrt(n)
  
  # check if the CI covered (=contained) the true but unknown mu
  return((lower < mu) & (mu < upper))
}

mean(replicate(1e5, ciexample()))
