class Node():
    def __init__(self, data):
        self.left = None
        self.right = None
        self.data = data

    def insert(self, data):
        if self.data:
            if data < self.data:
                if self.left is None:
                    self.left = Node(data)
                else:
                    self.left.insert(data)
            elif data > self.data:
                if self.right is None:
                    self.right = Node(data)
                else:
                    self.right.insert(data)
        else:
            self.data = data

    def pre_order(self, root):
        if root:
            print(" %d" % root.data, end="")
            self.pre_order(root.left)
            self.pre_order(root.right)
    
    def in_order(self, root):
        if root:
            self.pre_order(root.left)
            print(" %d" % root.data, end="")
            self.pre_order(root.right)

    def post_order(self, root):
        if root:
            self.pre_order(root.left)
            self.pre_order(root.right)
            print(" %d" % root.data, end="")

c = int(input())

for case in range(1, c+1):
    print("Case %d:" % case)
    n = input()

    arr = list(map(int, input().split()))

    root = Node(arr[0])
    for x in range(1, len(arr)):
        root.insert(arr[x])

    print("Pre.:", end="")
    root.pre_order(root)
    print()

    print("In..:", end="")
    root.in_order(root)
    print()

    print("Post:", end="")
    root.post_order(root)
    print()

    if (case != c):
        print()



