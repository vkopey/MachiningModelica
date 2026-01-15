import sys
sys.path.append(r"d:\OpenModelica1.18.1-64bit\share\omc\scripts\PythonInterface")
import numpy as np

# середні значення
m=7.0
c=1.0e7
d=3000.0
sigma=10.0

M=np.linspace(m-m/10.0, m+m/10.0, 5)
C=np.linspace(c-c/10.0, c+c/10.0, 5)
D=np.linspace(d-d/10.0, d+d/10.0, 5)
S=np.linspace(sigma-sigma/10.0, sigma+sigma/10.0, 5)

#X = np.array([[x, y] for x in X for y in Y]) # або
arrays = [M,C,D,S]
grids = np.meshgrid(*arrays, indexing='ij')
X = np.stack(grids, axis=-1).reshape(-1, len(arrays)) # комбінації

from OMPython import OMCSession
omc = OMCSession()
omc.sendExpression('loadFile("my.mo")')

Y=[]
for m,c,d,sigma in X:
    omc.sendExpression('setComponentModifierValue(my, mass.m, $Code(=%f))'%m)
    omc.sendExpression('setComponentModifierValue(my, springDamper.c, $Code(=%f))'%c)
    omc.sendExpression('setComponentModifierValue(my, springDamper.d, $Code(=%f))'%d)
    omc.sendExpression('setComponentModifierValue(my, normalNoise.sigma, $Code(=%f))'%sigma)
    omc.sendExpression('simulate(my)')
    y=omc.sendExpression('val(mean1.y, 1)')
    print(y)
    Y.append(y)

np.savetxt('X.dat', X)
np.savetxt('Y.dat', Y)