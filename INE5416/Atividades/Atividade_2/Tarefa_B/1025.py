def binarrySearch(arr, v):
    i = 0
    j = len(arr)

    while(i < j):
        m = (i+j)//2

        if(arr[m] < v):
            i = m + 1
        else:
            j = m

    if(i >= len(arr)):
        return -1

    if (arr[i] == v):
        return i+1
    else:
        return -1

T = 1
while True:
    N, Q = [int(x) for x in input().split()]

    if(N == 0 and Q == 0):
        break

    arr = []
    for _ in range(N):
        arr.append(int(input()))
    arr.sort()

    print('CASE# %d:' % T)
    T += 1
    for _ in range(Q):
        c = int(input())

        r = binarrySearch(arr, c)
        if(r == -1):
            print('%d not found' % c)
        else:
            print('%d found at %d' % (c, r))

