import random

def generate_random_rna(length=15):
    bases = ['A', 'U', 'C', 'G']
    return ''.join(random.choice(bases) for _ in range(length))

random_rna = generate_random_rna()
print(random_rna)