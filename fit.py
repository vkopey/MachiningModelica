import numpy as np
from scipy.optimize import curve_fit

m=7.0
c=1.0e7
d=3000.0
sigma=10.0

M=np.linspace(m-m/10.0, m+m/10.0, 50)
C=np.linspace(c-c/10.0, c+c/10.0, 50)
D=np.linspace(d-d/10.0, d+d/10.0, 5)
S=np.linspace(sigma-sigma/10.0, sigma+sigma/10.0, 5)


X=np.loadtxt('X.dat')
y=np.loadtxt('Y.dat')

def fp(x, a,b,c,d,f):
    x0,x1,x2,x3=x
    #return a*x0**2+b*x1**2+c*x2**2+d*x3**2+f
    return f*(x0**a*x3**b)/(x1**c*x2**d)

popt, pcov = curve_fit(fp, X.T, y)
R2=np.corrcoef(y, fp(X.T, *popt))[0,1]**2
print(R2)

from mpl_toolkits.mplot3d import axes3d
import matplotlib.pyplot as plt
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
#x0,x1=np.meshgrid(np.array([0,1,2]),np.array([0,1,2]))
i=(X[:,2]==D[2]) & (X[:,3]==S[2]) # тільки ті рядки, де
ax.scatter(X[:,0][i], X[:,1][i], y[i])
xx0, xx1 = np.meshgrid(M, C)
yy=fp((xx0, xx1, D[2], S[2]),*popt)
#yy=f((xx0, xx1, D[2], S[2]))
ax.plot_wireframe(xx0, xx1, yy, rstride=1, cstride=1)
ax.set_xlabel('x0');ax.set_ylabel('x1');ax.set_zlabel('y');plt.show()

#PySr
def f(x):
 x0,x1,x2,x3=x
 #return ((((((x2 / ((x1 / x2) + np.exp(x2 / np.exp(x0)))) + -0.7398679) / x2) / 0.89436805) + (x3 * 0.00010683017)) / x2) - 4.7163045e-8
 #return ((0.37195 / (x1 + (x2**1.982))) +1.1794e-08) * x3
 #return (((0.37194818 / (x1 + (x2 ** 1.9820116)))+1.5320524e-8) * x3) - (2.4646283e-7 / x0)
 return (x3 - (3.5199142 / x0)) * (((((np.exp(x0) / ((x1 - np.exp(x3)) - (x2 ** 1.9820116))) * np.exp(0.086113796)) + 0.37194815) / ((x2 ** 1.9820116) + x1)) - -1.3450915e-8)


R2=np.corrcoef(y, f(X.T))[0,1]**2
print(R2)