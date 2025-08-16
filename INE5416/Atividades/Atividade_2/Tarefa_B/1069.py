n = int(input())

for _ in range(n):
    d = input()
    d = d.replace(".", "")
    count = 0
    while "<>" in d:
        count += d.count("<>")
        d = d.replace("<>", "")
        
    print(count)
