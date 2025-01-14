#from rna import generate_random_rna
import random
def can_pair(b1, b2):
    valid_pairs = {("A", "U"), ("U", "A"),
                   ("C", "G"), ("G", "C"),
                   ("G", "U"), ("U", "G")}
    return (b1, b2) in valid_pairs

def nussinov(sequence):
    n = len(sequence)
    E = [[0] * n for _ in range(n)]
    for l in range(3, n):
        for i in range(n - l):
            j = i + l
            #print(f"i: {i}, j: {j}")
            max_val = E[i+1][j]  
            
            if E[i][j-1] > max_val:
                max_val = E[i][j-1]
            
            if can_pair(sequence[i], sequence[j]):
                pair_val = E[i+1][j-1] + 1 if (j - i) > 1 else 1
                if pair_val > max_val:
                    max_val = pair_val
            for k in range(i, j):
                split_val = E[i][k] + E[k+1][j]
                if split_val > max_val:
                    max_val = split_val
            E[i][j] = max_val
    return E

def backtrack(E, sequence, i, j, pairs):
    if i >= j:
        return
    print(f"// backtrack: i={i}, j={j}, E[i][j]={E[i][j]}")
    if E[i][j] == E[i+1][j]:
        backtrack(E, sequence, i+1, j, pairs)
    elif E[i][j] == E[i][j-1]:
        backtrack(E, sequence, i, j-1, pairs)
    elif can_pair(sequence[i], sequence[j]) and E[i][j] == E[i+1][j-1] + 1:
        pairs.append((i, j))
        backtrack(E, sequence, i+1, j-1, pairs)
    #for k in range(i, j):
       #if E[i][j] == E[i][k] + E[k+1][j]:
            #pairs.append((i, k))
            #pairs.append((k+1, j))
            #print("// case: split at k=%d" % k)
            #backtrack(E, sequence, i, k, pairs)
            #backtrack(E, sequence, k+1, j, pairs)
    return

def backtrack1(E, sequence, i, j, pairs):
    if i >= j:
        return
    #print(f"// backtrack: i={i}, j={j}, E[i][j]={E[i][j]}")
    
    conditions = [
        (E[i][j] == E[i+1][j], lambda: backtrack1(E, sequence, i+1, j, pairs)),
        (E[i][j] == E[i][j-1], lambda: backtrack1(E, sequence, i, j-1, pairs)),
        (can_pair(sequence[i], sequence[j]) and E[i][j] == E[i+1][j-1] + 1, lambda: (pairs.append((i, j)), backtrack1(E, sequence, i+1, j-1, pairs)))
    ]
    
    valid_conditions = [cond for cond in conditions if cond[0]]
    
    if valid_conditions:
        selected_condition = random.choice(valid_conditions)
        selected_condition[1]()
    
    return

def build_structure(sequence, pairs):
    all_structures = set()
    for pairs in all_pairs:
        structure = ["." for _ in range(len(sequence))]
        for (x, y) in pairs:
            structure[x] = "("
            structure[y] = ")"
            all_structures.add("".join(structure))
    return list(all_structures)

if __name__ == "__main__":
    #seq = generate_random_rna(4) 
    #print(f"Generated RNA sequence: {seq}")
    seq="GUACGUGUGCGU"
    E = nussinov(seq)
    for row in E :
        print(row)

all_pairs = [] 
for i in range(5):
    pairs = []
    backtrack1(E, seq, 0, len(seq) - 1, pairs)
    all_pairs.append(pairs)
    #print(all_pairs)

length = []
build_structure(seq, all_pairs)  
print("Predicted structure:", build_structure(seq, all_pairs))

def all_elements_equal(lst):
    return all(x == lst[0] for x in lst)

# 示例
lst = [1, 1, 1, 1]
print(all_elements_equal(lst))  # 输出: True

lst = [1, 2, 1, 1]
print(all_elements_equal(lst))  # 输出: False