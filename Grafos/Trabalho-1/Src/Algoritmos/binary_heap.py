class BinaryHeap:
    def __init__(self, heap: list[float]) -> None:
        self.heap: list[float] = heap
        self.tail: int = len(self.heap)-1
        self.build_heap()

    def build_heap(self) -> None:
        for i in range(self.parent(self.tail), -1, -1):
            self.heapify(i)

    def add(self, n: int) -> None:
        self.tail += 1
        self.heap.append(n)

        i: int = self.tail
        while ((i > 0) and (self.heap[self.parent(i)] > self.heap[i])):
            self.heap[i], self.heap[self.parent(i)] = self.heap[self.parent(i)], self.heap[i]
            i = self.parent(i)

    def remove(self) -> float:
        assert (not self.isEmpty())
        element: float = self.heap[0]
        if (len(self.heap) > 1):
            self.heap[0] = self.heap.pop()
        else:
            self.heap.pop()
        self.tail -= 1
        self.heapify(0)
        return element


    def heapify(self, index: int) -> None:
        if ((self.isLeaf(index)) or (not self.isValidIndex(index))):
            return

        min_index: int = self.min_index(index, self.left(index), self.right(index))

        if (min_index != index):
            self.heap[index], self.heap[min_index] = self.heap[min_index], self.heap[index]
            self.heapify(min_index)


    def min_index(self, index: int, left: int, right: int) -> int:
        if (self.heap[index] < self.heap[left]):
            if (self.isValidIndex(right)):
                if (self.heap[index] > self.heap[right]):
                    return right;
            return index
        else:
            if (self.isValidIndex(right)):
                if (self.heap[left] > self.heap[right]):
                    return right
            return left

    def isValidIndex(self, index: int) -> bool:
        return ((index >= 0) and (index <= self.tail))

    def isLeaf(self, index: int) -> bool:
        return ((index > self.parent(self.tail)) and (index <= self.tail))

    def left(self, index: int) -> int:
        return (2*index)+1

    def right(self, index: int) -> int:
        return 2*(index+1)

    def parent(self, index: int) -> int:
        return (index-1)//2

    def isEmpty(self) -> bool:
        return self.tail == -1


    
        

