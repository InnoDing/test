# 原始数据
X <- c(
  5, 3, 6, 7, 5, 6, 5, 5, 4, 3, 
  6, 7, 5, 5, 6, 5, 5, 5, 1, 7, 
  3, 5, 7, 7, 7, 6, 7, 2, 5, 5, 
  2, 6, 5, 2, 5, 6, 5, 6, 6, 3, 
  6, 5, 6, 6, 6, 5, 6, 2, 5, 5, 
  7, 5, 7, 5, 3, 4, 1, 2, 5, 5
)

# 统计频数
counts <- table(X)
n <- sum(counts)

alpha <- 0.5
post_mean_alpha <- (counts + alpha) / (n + length(counts)*alpha)

# 显示估计结果
post_mean
sum(post_mean)  # 验证是否等于1
