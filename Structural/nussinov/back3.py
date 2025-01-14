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
            #pairs.append((i, k))
            #pairs.append((k+1, j))
            print("// case: split at k=%d" % k)
            backtrack(E, sequence, i, k, pairs)
            backtrack(E, sequence, k+1, j, pairs)
            return