
#### reg 1

S <- read.csv("reg1.csv")
x <- S$x
y <- S$y

plot(x,y)

###   Y = b0 + b1 * X
model <- lm(y ~ x, data = S) 
abline(model, col = "red")

summary(model)
coefficients(model)
model$coefficients
model$residuals
hist(model$residuals, freq = F, breaks = "Scott")

plot(x, model$residuals)



#### reg 2

S2 <- read.csv("reg2.csv")

model2 <- lm(formula = y ~ x, data = S2)
plot(S2$x, S2$y)
abline(model2, col ="red")
plot(S2$x, model2$residuals)

### poly regression

plot(S2$x, S2$y)
#model_pol <- lm(y ~ poly(x, degree = 2 ), data = S2)

model_pol <- lm(y ~ I(x^2) + x, data = S2)
coefficients(model_pol)
summary(model_pol)
temp_x <- seq(-3, 3, length.out = 100)
temp_y <- predict(object = model_pol, 
                  newdata = data.frame(x = temp_x) )
lines(temp_x, temp_y, col = "red")
plot(S2$x, model_pol$residuals)



#### reg 3

S3 <- read.csv("reg3.csv")

x <- S3$x
y <- S3$y

plot(x,y)

lin_mod <- lm(y ~ x, data = S3)
abline(lin_mod, col = "red")
plot(x, lin_mod$residuals)

lin_pol3 <- lm( y ~ poly(x, 3), data = S3)
temp_x <- seq(-3, 3, length.out = 100)
temp_y <- predict(object = lin_pol3, 
                  newdata = data.frame( x= temp_x))
lines(temp_x, temp_y, col = "blue")
plot(x, lin_pol3$residuals)

### 

mod3 <- lm( y ~ exp(x), data = S3)
temp_y <- predict(object = mod3, 
                  newdata = data.frame( x= temp_x))
plot(x, y)
lines(temp_x, temp_y, col ="blue")

plot(x, mod3$residuals)
