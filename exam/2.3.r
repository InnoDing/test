set.seed(1)

# 先随机选择候选元素
candidates <- sample(1:5000, size = 30, replace = FALSE)

# 使用矩阵运算优化子集生成和计算
library(gtools)

# 创建一个函数来生成子集矩阵，每行代表一个子集
generate_subset_matrix <- function(candidates, max_sub_size) {
  subset_rows <- list()
  n <- length(candidates)
  
  for (k in 1:max_sub_size) {
    combs_k <- combinations(n, k)
    subset_matrix <- matrix(0, nrow = nrow(combs_k), ncol = n)
    for (i in 1:nrow(combs_k)) {
      subset_matrix[i, combs_k[i,]] <- 1
    }
    subset_rows[[k]] <- subset_matrix
  }
  
  do.call(rbind, subset_rows)
}

# 生成子集矩阵
subset_matrix <- generate_subset_matrix(candidates, max_sub_size = 3)

# 创建一个向量存储所有候选元素的 nnp 值
nnp_values <- numeric(length(candidates))
for (i in seq_along(candidates)) {
  nnp_values[i] <- omega_df$nnp[omega_df$element == candidates[i]]
}

# 计算所有子集的和（矩阵乘法）
subset_sums <- subset_matrix %*% nnp_values

# 计算所有可能的交集（矩阵乘法）
intersection_matrix <- subset_matrix %*% t(subset_matrix)

# 检查独立性
n_subsets <- nrow(subset_matrix)
for (i in 1:n_subsets) {
  for (j in 1:n_subsets) {
    if (i == j) next
    
    sumD <- subset_sums[i]
    sumE <- subset_sums[j]
    sumDE <- intersection_matrix[i,j] * nnp_values
    
    # 独立性检查
    left_side <- sum(sumDE)
    right_side <- (sumD * sumE) / nnp_sum
    
    if (abs(left_side - right_side) < 1e-12) {
      cat("找到独立事件:\n",
          "D =", candidates[subset_matrix[i,] == 1], 
          "\nE =", candidates[subset_matrix[j,] == 1], "\n",
          "sumDE =", left_side, 
          "\nsumD * sumE / S_tot =", right_side, "\n\n")
      return(invisible())
    }
  }
}

cat("未找到独立事件！\n")