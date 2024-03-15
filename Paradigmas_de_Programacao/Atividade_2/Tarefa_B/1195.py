def new_node(data):
    dict = {
        "left"  : None,
        "right" : None,
        "data"  : data
    }
    return dict.copy()

def insert(root, values):
    while (len(values) > 0):
        v = values.pop(0)
        previous = root
        actual = root
        way = ""

        while True:
            if (not actual):
                if (way == "right"):
                    previous["right"] = new_node(v)
                else:
                    previous["left"] = new_node(v)
                break

            previous = actual

            if (actual["data"] < v):
                way = "right"
                actual = actual["right"]
            else:
                way = "left"
                actual = actual["left"]


def in_order(root, arr):
    if (root["left"] != None):
        in_order(root["left"], arr)
    arr.append(root["data"])
    if (root["right"] != None):
        in_order(root["right"], arr)

def pre_order(root, arr):
    arr.append(root["data"])
    if (root["left"] != None):
        pre_order(root["left"], arr)
    if (root["right"] != None):
        pre_order(root["right"], arr)

def post_order(root, arr):
    if (root["left"] != None):
        post_order(root["left"], arr)
    if (root["right"] != None):
        post_order(root["right"], arr)
    arr.append(root["data"])


n = int(input())
for case in range(1, n+1):
    print("Case %d:" % case)

    n = int(input())
    values = list(map(int, input().split()))

    root = new_node(values.pop(0))

    insert(root, values)

    arr = list()
    pre_order(root, arr)
    print("Pre.: " + " ".join(list(map(str, arr))))

    arr = list()
    in_order(root, arr)
    print("In..: " + " ".join(list(map(str, arr))))

    arr = list()
    post_order(root, arr)
    print("Post: " + " ".join(list(map(str, arr))))

    print()

