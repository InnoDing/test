# data
1:10
c(1, 2, 5)

seq(1, 10, length.out = 3)
seq(1, 10, 2)

m <- matrix(c(1, 2, 3, 4), nrow = 2)
apply(m,
      MARGIN = 1,
      FUN = function(x) sum(x)^2)
sapply(1:3, function(x) x^2)
df <- data.frame(x = c(1, 2), y = c(3, 4))
names(df)
colnames(df)
rownames(df)
head(df)
tail(df)
# levels / factor
# selection: df[1,], df[,1], df[, c("x")], ...
# subset

ncol(m)
nrow(m)
dim(m)

r <- replicate(5, sample(c("a", "b"), size = 1))
table(r)

sample(c(1:10))
sample(c(1:3),
       size = 10,
       replace = TRUE, 
       prob = c(2/3, 1/6, 1/6))

# reading data (will be given in exercises/exam)
# read.csv
# read.table

# control structures
# functions and explicit Vectorize
f <- function(a, b = 1) {
  return(sum(a) + b)
}
f(1)
f(1, 2)
f(c(1, 2))
Vectorize(f)(c(1, 2))

if (f(1) == f(1, 2)) {
  print("f defaults to b = 2")
} else if (f(1) == f(1, 1)) {
  print("f defaults to b = 1")
} else {
  print("i don't know")
}

a <- 2
while (a < 5) {
  a <- a^2
}
a

for (i in seq(1, 10, .5)) {
  a <- a + i
}
a

# *exp, *gamma, *unif, *dlnorm, *dpois, 
# *dbinom, *dbeta, ...
# *sin (exercise)
# density
dnorm(10)
# distribution function
pnorm(0)
# quantile function("inverse" of the cdf)
qnorm(.5)
# random generation
rnorm(1)

mean(runif(1000))
sd(rnorm(1000))
var(rnorm(1000))

# empirical quantiles
quantile(rnorm(1000), .5)

# plot
plot(runif(10))
points(runif(10))
lines(runif(10))
curve(dexp(x, rate = .5), add = TRUE)
# legend()
# abline()
# par(new=TRUE) – combine plots

# boxplot
boxplot(runif(100))

# qqnorm / qqplot
# comparing against normal
qqnorm(runif(100))
# comparing two
qqplot(runif(1000), 2 * runif(1000) + 1)

# histogram and density
hist(rexp(1000))
d <- density(rexp(1000))
para(add = TRUE)
plot(d)

# empirical cdf
e <- ecdf(runif(100))
plot(e)

# integrate

# optim / optimize (numerically find the MLE)
# ..collect from exercises..

# tests
# t.test
# chisq.test
# chisq.test(x, p = p)
# chisq.test(x, y)

# ...