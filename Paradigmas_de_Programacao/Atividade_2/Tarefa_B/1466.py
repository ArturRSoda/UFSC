class Node:
    def __init__(self, data):
        self.data = data
        self.left = None
        self.right = None

def insert(root, data):
    if (root == None):
        return Node(data)

    if (data <= root.data):
        root.left = insert(root.left, data)
    else:
        root.right = insert(root.right, data)

    return root

def func(root):
    i = 0
    f = 1

    queue = list()
    queue.append(root)
    v = False

    while (f > i):
        root = queue[i]
        i += 1
        if (v):
            print(" %d" % root.data, end="")
        else:
            print("%d"%root.data, end="")
            v = True

        if (root.left):
            queue.append(root.left)
            f += 1
        if (root.right):
            queue.append(root.right)
            f += 1


c = int(input())
for case in range(1, c+1):
    print("Case %d:" % case)

    n = int(input())

    root = None
    for x in input().split():
        root = insert(root, int(x))

    func(root)
    print("\n")
