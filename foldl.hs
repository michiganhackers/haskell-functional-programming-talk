sum :: [Int] -> Int
sum xs = foldl (\acc x -> x + acc) 0 xs
