# Correlation and covariance

## generate data
n <- 100
beta <- 2
x <- runif(n, min=-1, max=1)
y <- beta * x + rnorm(n)

plot(x, y)

## sample covariance..
s_XY <- (1 / (n - 1)) * sum((x - mean(x)) * (y - mean(y)))
s_XY
## ..can also be computed using the built-in cov function
cov(x, y)

## sample correlation..
rho_XY <- s_XY / (sd(x) * sd(y))
rho_XY
## ..can also be computed using the built-in cor function
cor(x, y)

## relationship between correlation
## and linear model coefficients
### compare..
s_XY / var(x)
s_XY / var(y)
### ..to..
fit <- lm(y ~ x, data.frame(x=x, y=y))
abline(fit, col = "blue")
fit$coefficients["x"]
### ..and..
beta



# a few examples
# try different beta
beta <- 20
y <- beta * x + rnorm(n)
plot(x, y)
cor(x, y)

y <- -beta * x + rnorm(n)
plot(x, y)
cor(x, y)

y <- beta * x^2 + rnorm(n)
plot(x, y)
cor(x, y)

# demonstration of
# no correlation [does not!] imply no dependence
a <- runif(100, min=-pi, max=pi)
x <- sin(a) + rnorm(100) / 10
y <- cos(a) + rnorm(100) / 10
plot(x, y)
cor(x, y)





# generalized linear regression: logistic

## simulate data
x <- runif(100, min=-1, max=1)
beta0 <- 0
beta1 <- 10
# (cf. slides)
px <- exp(beta0 + beta1 * x) / (1 + exp(beta0 + beta1 * x))

plot(x, px)
plot(x, beta0 + beta1*x)

y <- sapply(px,
            function(p) rbinom(1, 1, p))

plot(x, y)
points(x, px, col="blue")

fit <- glm(y ~ x, family = binomial)
summary(fit)

points(x,
       exp(predict(fit)) / (1 + exp(predict(fit))),
       col="green")

# alternatively
points(x,
       binomial()$linkinv(predict(fit)))



# generalized linear regression: poisson

## simulate data
x <- runif(100, min=-1, max=1)
beta0 <- 3
beta1 <- 1
lambdax <- exp(beta0 + beta1 * x)

plot(x, lambdax)

y <- sapply(lambdax,
            function(lambda) rpois(1, lambda))

plot(x, y)
points(x, lambdax, col="blue")

fit <- glm(y ~ x, family = poisson)
summary(fit)

points(x,
       exp(predict(fit)),
       col="green")

# alternatively
points(x,
       poisson()$linkinv(predict(fit)),
       col="red")





# model diagnostics and modelling assumptions:
# are noise terms independent of X?

# regression diagnostics
n <- 100
x <- runif(n, min=-3, max=3)
y <- x**3 + rnorm(n)

plot(x, y)

fit1 <- lm(y ~ x, data.frame(x=x, y=y))

abline(fit1, col="blue")

summary(fit1)

confint(fit1)

plot(x, residuals(fit1))

qqnorm(residuals(fit1))
qqline(residuals(fit1))

## cubic linear regression 
fit2 <- lm(y ~ I(x^3) + I(x^2) + x)
summary(fit2)
plot(x, residuals(fit2))
qqnorm(residuals(fit2))
qqline(residuals(fit2))

## cubic linear regression with one term 
fit3 <- lm(y ~ I(x^3) - 1)
summary(fit3)
plot(x, residuals(fit3))
qqnorm(residuals(fit3))
qqline(residuals(fit3))

AIC(fit1, fit2, fit3)
BIC(fit1, fit2, fit3)
