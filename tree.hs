data Tree = Nil | Node Tree Int Tree

contains :: Tree -> Int -> Bool
contains Nil x = False
contains (Node t1 v t2) x
    | x == v = True
    | x  < v = contains t1 x
    | x  > v = contains t2 x
