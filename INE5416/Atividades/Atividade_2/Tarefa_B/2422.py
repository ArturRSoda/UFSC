n = int(input())

arr = list()
for _ in range(n):
    arr.append(int(input()))

k = int(input())

i = 0
j = n-1
while (i < j):
    s = arr[i] + arr[j]
    if (s > k):
        j -= 1
    elif (s < k):
        i += 1
    else:
        print(arr[i], arr[j])
        break


