#from rna import generate_random_rna
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
            print(f"i: {i}, j: {j}")
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
    for k in range(i, j):
        if E[i][j] == E[i][k] + E[k+1][j]:
            print("// case: split at k=%d" % k)
            backtrack(E, sequence, i, k, pairs)
            backtrack(E, sequence, k+1, j, pairs)
            return

def build_structure(sequence, pairs):

    structure = ["." for _ in range(len(sequence))]
    for (x, y) in pairs:
        structure[x] = "("
        structure[y] = ")"
    return "".join(structure)

if __name__ == "__main__":
    #seq = generate_random_rna(4) 
    #print(f"Generated RNA sequence: {seq}")
    seq="GUACGUGUGCGU"
    E = nussinov(seq)
    for row in E :
        print(row)
    
    pairs = []
    backtrack(E, seq, 0, len(seq) - 1, pairs)
    print(pairs)

    print("Predicted structure:", build_structure(seq, pairs))                                                                              