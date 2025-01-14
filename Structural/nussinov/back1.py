def backtrack1(E, sequence, i, j, pairs):
    if i >= j:
        return
    print(f"// backtrack: i={i}, j={j}, E[i][j]={E[i][j]}")
    if E[i][j] == E[i+1][j]:
        backtrack1(E, sequence, i+1, j, pairs)
    elif E[i][j] == E[i][j-1]:
        backtrack1(E, sequence, i, j-1, pairs)
    elif can_pair(sequence[i], sequence[j]) and E[i][j] == E[i+1][j-1] + 1:
        pairs.append((i, j))
        backtrack1(E, sequence, i+1, j-1, pairs)
    return

import random
def can_pair(b1, b2):
    valid_pairs = {("A", "U"), ("U", "A"),
                   ("C", "G"), ("G", "C"),
                   ("G", "U"), ("U", "G")}
    return (b1, b2) in valid_pairs

def backtrack1(E, sequence, i, j, pairs):
    if i >= j:
        return
    print(f"// backtrack: i={i}, j={j}, E[i][j]={E[i][j]}")
    
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