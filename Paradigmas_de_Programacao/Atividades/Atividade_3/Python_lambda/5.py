print("Maior =", (lambda a,b,c: a if ((a>=b) and (a>=c)) else b if ((b>=a) and (b>=c)) else c)(int(input()), int(input()), int(input())))
