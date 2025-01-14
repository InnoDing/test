# load data
isi <- read.csv("neuronspikes.txt", header = FALSE)$V1
hist(isi, probability = TRUE)


# statistical model:
# M = {exponential distribution with rate >= 0}
curve(dexp(x, rate = 1),
      add = TRUE, col = "dark red",
      from = 0)


# define likelihood (exponential distribution)
exp_L <- Vectorize(function(rate) {
  prod(dexp(isi, rate = rate))
})


# plot likelihood
curve(exp_L(x), from = 0, to = 3,
      xlab = "rate",
      ylab = "L(rate)")


# maximise likelihood
oL <- optimize(exp_L, interval = c(0, 3),
               maximum = TRUE)


# define log-likelihood (cf. slides)
exp_ll <- Vectorize(function(rate) {
  n <- length(isi)
  return(n * log(rate) -
           rate * sum(isi))
})


# plot log-likelihood
curve(exp_ll(x), from = 0, to = 3,
      xlab = "rate",
      ylab = "log(L(rate))")


# maximise log-likelihood
oll <- optimize(exp_ll, interval = c(0, 3),
                maximum = TRUE)

hist(isi, probability = TRUE)

curve(dexp(x, rate = oll$maximum),
      add = TRUE, col = "dark green",
      from = 0)

curve(dexp(x, rate = 2.5),
      add = TRUE, col = "dark red",
      from = 0)
