from sklearn import manifold, datasets
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from scipy.spatial.distance import cdist
import numpy as np
import time
Axes3D


n_points = 1000
X, color = datasets.samples_generator.make_s_curve(n_points, random_state=0)
# x = np.linspace(0, 10, 20)
# y = np.linspace(0, 10, 20)
# x, y = np.meshgrid(x, y)
# x = x + np.random.randn(20) * 0.01
# y = y + np.random.randn(20) * 0.01
# z = np.sin(x)
# X = np.vstack((x.flatten(), y.flatten(), z.flatten())).T
# print(X.shape)
n_neighbors = 10

tic = time.process_time()
dist = cdist(X, X)
w = np.zeros_like(dist)
tol = 1e-4


for i in range(n_points):
    idx = np.argsort(dist[i])[1:n_neighbors+1]
    neighbors = X[idx]
    Z = neighbors - X[i]
    inv = np.linalg.pinv(Z @ Z.T + np.eye(n_neighbors) * tol)
    w_tmp = np.sum(inv, 1) / np.sum(inv)
    w[idx, i] = w_tmp

I = np.eye(n_points)
M = (I - w) @ (I - w).T
u, s, vh = np.linalg.svd(M)
toc = time.process_time()

fig = plt.figure()
ax = fig.add_subplot(121, projection='3d')
ax.scatter(X[:, 0], X[:, 1], X[:, 2], c=color, cmap=plt.cm.Spectral)

ax = fig.add_subplot(122)
plt.scatter(u[:, -2], u[:, -3], c=color, cmap=plt.cm.Spectral)
plt.show()

print(toc - tic)