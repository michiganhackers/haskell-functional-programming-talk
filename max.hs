max' :: [Int] -> Int
max' [] = error "Must provide a non-empty list"
max' [x] = x
max' (x:xs)
  | x > max' xs = x
  | otherwise = max' xs
