def hamming_distance(seq1, seq2):
    """计算两个等长序列之间的汉明距离"""
    if len(seq1) != len(seq2):
        raise ValueError("序列长度必须相同")
    return sum(c1 != c2 for c1, c2 in zip(seq1, seq2))

def get_base_pairs(dot_bracket):
    """从点括号表示法中提取碱基对位置"""
    pairs = []
    stack = []
    
    for i, char in enumerate(dot_bracket):
        if char == '(':
            stack.append(i)
        elif char == ')':
            if stack:
                pairs.append((stack.pop(), i))
    return set(pairs)

def base_pair_distance(dot_bracket1, dot_bracket2):
    """计算两个RNA结构之间的碱基对距离"""
    if len(dot_bracket1) != len(dot_bracket2):
        raise ValueError("结构长度必须相同")
        
    pairs1 = get_base_pairs(dot_bracket1)
    pairs2 = get_base_pairs(dot_bracket2)
    
    return len(pairs1.symmetric_difference(pairs2))

def compare_rna_sequences(wt_seq, mut_seq, wt_struct, mut_struct):
    """比较野生型和突变型RNA的汉明距离和碱基对距离"""
    ham_dist = hamming_distance(wt_struct, mut_struct)
    bp_dist = base_pair_distance(wt_struct, mut_struct)
    
    return ham_dist, bp_dist

# 测试代码
if __name__ == "__main__":
    print("请输入RNA序列和结构信息：")
    print("注意：序列和结构的长度必须相同")
    
    wt_seq = input("请输入野生型RNA序列: ").strip()
    mut_seq = input("请输入突变型RNA序列: ").strip()
    wt_struct = input("请输入野生型结构 (点括号表示): ").strip()
    mut_struct = input("请输入突变型结构 (点括号表示): ").strip()
    
    try:
        ham_dist, bp_dist = compare_rna_sequences(wt_seq, mut_seq, wt_struct, mut_struct)
        print("\n计算结果：")
        print(f"Hamming距离: {ham_dist}")
        print(f"碱基对距离: {bp_dist}")
    except ValueError as e:
        print(f"错误：{e}") 