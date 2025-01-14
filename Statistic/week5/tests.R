real_mu <- 5 
real_sigma <- 2
n <- 100
X <- rnorm(n, real_mu, real_sigma)



# Wald test

alpha <- 0.05

mu0 <- 5.1
Wstat <- abs((mean(X) - mu0) * sqrt(n) / real_sigma)
Wstat 
qnorm(1 - alpha / 2)

p_value <- 2 * (1 - pnorm(Wstat))
p_value



# t-test 

alpha <- 0.05

mu0 <- 5.1
tstat <- abs((mean(X) - mu0) * sqrt(n) / sd(X))
tstat
qt(1 - alpha / 2, df = n - 1)

p_value <- 2 * (1 - pt(tstat, df = n - 1))
p_value

t.test(X, mu = mu0)



# one-sample t-test

# install.packages("datarium")
data(mice, package = "datarium")

summary(mice)

res <- t.test(mice$weight, mu = 25)
res



# two-sample t-test

# install.packages("datarium")
data(genderweight, package = "datarium")

summary(genderweight)

summary(genderweight[1:20,])
summary(genderweight[21:40,])

res <- t.test(genderweight[1:20, 3], genderweight[21:40, 3])
res

res <- t.test(weight ~ group, data = genderweight)
res



# Contingency table and independence test 

# install.packages("ISLR")
library(ISLR)
head(Wage)

cont <- table(Wage$maritl, Wage$jobclass)
cont

mosaicplot(t(cont))

res <- chisq.test(cont)
res

res$observed
res$expected

Wage$wage_cat <- as.factor(
  ifelse(Wage$wage > median(Wage$wage),
         "Above",
         "Below"))

cont <- table(Wage$wage_cat, Wage$jobclass)
res <- chisq.test(cont)
res

summary(Wage$jobclass)
chisq.test(table(Wage$jobclass))
chisq.test(table(Wage$jobclass), p = c(16/30, 14/30))
chisq.test(table(Wage$jobclass), p = c(.45, .55))
chisq.test(table(Wage$jobclass), p = c(.3, .7))
