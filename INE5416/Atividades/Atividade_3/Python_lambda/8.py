print("fibonnaci =", ((lambda f: lambda n: f(f,n))(lambda f,n: 1 if (n <= 2) else f(f,n-2)+f(f,n-2)))(int(input())))
