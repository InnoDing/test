import numpy as np

# Point set a and b (from the problem description)
a = np.array([
    [18.92238689, 9.18841188, 8.70764463, 9.38130981, 8.53057997],
    [1.12391951, 0.8707568, 1.01214183, 0.59383894, 0.65155349],
    [0.46106398, 0.62858099, -0.02625641, 0.35264203, 0.53670857]
])

b = np.array([
    [1.68739355, 1.38774297, 2.1959675, 1.51248281, 1.70793414],
    [8.99726755, 8.73213223, 8.86804272, 8.31722197, 8.9924607],
    [1.1668153, 1.1135669, 1.02279055, 1.06534992, 0.5481902]
])

# Step 1: Center both sets to their respective center of mass
def center_to_mass(x):
    center_of_mass_x = x.sum(axis=1, keepdims=True) / x.shape[1]
    return x - center_of_mass_x

a_centered = center_to_mass(a)
b_centered = center_to_mass(b)

# Step 2: Compute the covariance matrix and perform Singular Value Decomposition (SVD)
H = a_centered @ b_centered.T
U, S, Vt = np.linalg.svd(H)

# Step 3: Compute the optimal rotation matrix U
R = Vt.T @ U.T

# Ensure proper rotation (determinant should be +1 for a proper rotation matrix)
if np.linalg.det(R) < 0:
    Vt[-1, :] *= -1
    R = Vt.T @ U.T

# Step 4: Rotate b and calculate RMSD
b_rotated = R @ b_centered

# RMSD calculation
rmsd = np.sqrt(np.mean(np.sum((a_centered - b_rotated)**2, axis=0)))

print(R, rmsd)
