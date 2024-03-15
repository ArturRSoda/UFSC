v1 = {"x" : 0, "y" : 0}
v2 = {"x" : 432, "y" : 468}
x, y = map(int, input().split())
print("dentro" if ((v1["x"] <= x <= v2["x"]) and (v1["y"] <= y <= v2["y"])) else "fora")

