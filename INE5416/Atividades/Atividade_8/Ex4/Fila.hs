module Fila (Fila (Queue),
             enqueue,
             dequeue,
             first,
             emptyQueue) where

data Fila t = Queue [t]
    deriving (Eq, Show)

enqueue :: Fila t -> t -> Fila t
enqueue (Queue s) y = Queue (s ++ [y])

dequeue :: Fila t -> Fila t
dequeue (Queue []) = error "Vazio"
dequeue (Queue (_:b)) = Queue b

first :: Fila t -> t
first (Queue []) = error "Vazio"
first (Queue (a:_)) = a

emptyQueue :: Fila t
emptyQueue = Queue []

