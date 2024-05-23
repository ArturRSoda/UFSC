print("x1 = ", end=""); x1 = float(input())
print("y1 = ", end=""); y1 = float(input())
print("z1 = ", end=""); z1 = float(input())
print("x2 = ", end=""); x2 = float(input())
print("y2 = ", end=""); y2 = float(input())
print("z2 = ", end=""); z2 = float(input())

print("distancia entre (x1,y1,z1) e (x2,y2,z2) = %.2f" % (lambda x1,y1,z1,x2,y2,z2: ((x1-x2)**2 + (y1-y2)**2 + (z1-z2)**2)**(1/2))(x1,y1,z1,x2,y2,z2))
