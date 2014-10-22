sum''' :: [Int] -> Int
sum''' []     = 0
sum''' (x:xs) = x + sum''' xs

sum' :: [Int] -> Int
sum' [] = 0
sum' xs = head xs + sum' (tail xs)

sum'' :: [Int] -> Int
sum'' []     = 0
sum'' [x]    = x
sum'' [x, y] = x + y
sum'' (x:xs) = x + sum'' xs

sum'''' :: [Int] -> Int
sum'''' xs = sumHelper xs 0

sumHelper :: [Int] -> Int -> Int
sumHelper [] soFar = soFar
sumHelper (x:xs) soFar = sumHelper xs (soFar + x)
