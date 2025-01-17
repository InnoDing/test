# 加载必要包
library(parallel)
library(gtools)
mynumber <- 631
load("exam202425.RData")
omega_df <- setup_omega(mynumber)
# 假设 omega_df 已经存在
nnp_sum <- sum(omega_df$nnp)
nnp_vec <- omega_df$nnp
names(nnp_vec) <- omega_df$element

# 定义SumNnp函数
SumNnp <- function(subset_elems) {
  sum(nnp_vec[ as.character(subset_elems) ])
}

# 随机选择候选元素
set.seed(123)
candidates <- sample(1:5000, size = 50, replace = FALSE)

# 生成所有子集
all_subs <- list()
max_sub_size <- 3
for (k in 1:max_sub_size) {
  combs_k <- combinations(length(candidates), k)
  for (row_i in seq_len(nrow(combs_k))) {
    subset_i <- candidates[ combs_k[row_i, ] ]
    all_subs <- c(all_subs, list(subset_i))
  }
}

# 预先计算所有子集的sumNnp值
sum_nnp_cache <- sapply(all_subs, SumNnp)

# 设置最大迭代次数
max_iterations <- 1e6
current_iter <- 0

# 初始化并行集群
# 初始化并行集群
# 初始化并行集群
cl <- makeCluster(detectCores() - 1)

# 导出所有需要的变量和函数
clusterExport(cl, c("SumNnp", "nnp_vec", "all_subs", 
                   "sum_nnp_cache", "candidates", 
                   "nnp_sum", "max_iterations"))  # 添加max_iterations

# 修改并行计算部分
results <- parLapply(cl, seq_along(all_subs), function(i) {
  # 使用局部变量记录迭代次数
  local_iter <- 0
  
  D <- all_subs[[i]]
  sumD <- sum_nnp_cache[i]
  
  for (j in seq_along(all_subs)) {
    if (j == i) next
    
    # 检查迭代次数
    local_iter <- local_iter + 1
    if (local_iter > max_iterations) {  # 现在可以访问max_iterations
      return(NULL)
    }
    
    E <- all_subs[[j]]
    sumE <- sum_nnp_cache[j]
    
    if (length(E) == length(candidates)) next
    
    # 计算 D∩E
    DE <- intersect(D, E)
    sumDE <- SumNnp(DE)
    
    # 独立性检查
    left_side  <- sumDE
    right_side <- (sumD * sumE) / nnp_sum
    diff_val <- abs(left_side - right_side)
    
    if (diff_val < 1e-12) {
      return(list(D = D, E = E, 
                  sumDE = left_side, 
                  expected = right_side))
    }
  }
  return(NULL)
})

# 停止集群
stopCluster(cl)

# 处理结果
found_results <- Filter(Negate(is.null), results)
if (length(found_results) > 0) {
  for (res in found_results) {
    cat("Potential match:\n",
        "D =", res$D, 
        "\nE =", res$E, "\n",
        "sumDE =", res$sumDE, 
        "\nsumD * sumE / nnp_sum =", res$expected, "\n\n")
  }
  found <- TRUE
} else {
  if (current_iter > max_iterations) {
    cat("Reached maximum iterations without finding a match!\n")
  } else {
    cat("No independent events found (under the small search)!\n")
  }
}