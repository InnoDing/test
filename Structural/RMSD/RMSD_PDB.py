import numpy as np
from Bio.PDB import PDBParser

def get_ca_coordinates(pdb_file, model_index, chain_id):
    parser = PDBParser(QUIET=True)
    structure = parser.get_structure("temp", pdb_file)
    model = list(structure)[model_index]  # 获取指定model
    chain = model[chain_id]
    coords = []
    for residue in chain:
        # 确保是标准氨基酸，并且有CA原子
        if 'CA' in residue:
            ca_atom = residue['CA']
            coords.append(list(ca_atom.get_coord()))
    return np.array(coords).T  # 返回3xN的坐标矩阵

def center_to_mass(x):
    center_of_mass_x = x.sum(axis=1, keepdims=True) / x.shape[1]
    return x - center_of_mass_x

# 从1LCD.pdb中提取model 0和model 1中Chain A的Cα坐标
a = get_ca_coordinates("/Users/liuxinpeng/Library/CloudStorage/OneDrive-stu.ouc.edu.cn/UCPH/Structual/1lcd.pdb", 0, 'A')
b = get_ca_coordinates("/Users/liuxinpeng/Library/CloudStorage/OneDrive-stu.ouc.edu.cn/UCPH/Structual/1lcd.pdb", 1, 'A')

# Step 1: 对两组坐标进行中心化
a_centered = center_to_mass(a)
b_centered = center_to_mass(b)

# Step 2: 计算协方差矩阵并进行SVD
H = a_centered @ b_centered.T
U, S, Vt = np.linalg.svd(H)

# Step 3: 计算最优旋转矩阵R
R = Vt.T @ U.T

# 确保旋转矩阵为右手系（正定行列式）
if np.linalg.det(R) < 0:
    Vt[-1, :] *= -1
    R = Vt.T @ U.T

# Step 4: 将b_centered旋转并计算RMSD
b_rotated = R @ b_centered
rmsd = np.sqrt(np.mean(np.sum((a_centered - b_rotated)**2, axis=0)))

print("Rotation Matrix R:")
print(R)
print("\nRMSD:", rmsd)
