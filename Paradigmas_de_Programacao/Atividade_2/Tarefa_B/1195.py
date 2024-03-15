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

def pre_order(root):
    if (root == None):
        return
    print(" %d" % root.data, end="")
    pre_order(root.left)
    pre_order(root.right)

def in_order(root):
    if (root == None):
        return
    in_order(root.left)
    print(" %d" % root.data, end="")
    in_order(root.right)

def post_order(root):
    if (root == None):
        return
    post_order(root.left)
    post_order(root.right)
    print(" %d" % root.data, end="")

c = int(input())
for case in range(1, c+1):
    print("Case %d:" % case)

    n = int(input())

    root = None
    for x in input().split():
        root = insert(root, int(x))

    print("Pre.:", end="")
    pre_order(root)
    print()

    print("In..:", end="")
    in_order(root)
    print()

    print("Post:", end="")
    post_order(root)
    print()

    if (case != c):
        print()


