arr = [1, 2, 3, 4, 5, 6]
print("array :", *arr)
print("Pares", *list(filter(lambda x: True if (x%2 == 0) else False, arr)))

