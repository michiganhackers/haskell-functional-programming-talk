# Introduction to Haskell

Here is the video of the talk if you want more in depth commentary :)

https://www.youtube.com/watch?v=f7IYRS7XgGU&list=UUi7ZzU3Ic7DcDW3mlCqaArw

## What is Haskell

- Functional, pure, programming language
- Interpreted or compiled
- Statically typed
- Lazy evaluation
- Higher Kinded Types (HKT), Algebraic data types, based on mathematical concepts

## Variables

```haskell
>>> let a = 1

>>> let b = 2.0

>>> let c = 'A'

>>> let d = "Hello World!"
```

Note: In GHCI, top level variable declarations must be preceded by the `let` keyword, but not in Haskell files

## Types?

- Hindley-Milner type inference

<div align=center>
What part of:

<img src="hindley-milner.png">

Don't you understand?
</div>

## Types

We can set the types for clarity using the `::` operator

```haskell
a :: Int
a = 1

b :: Float
b = 2.0

c :: Char
c = 'A'

d :: String
d = "Hello World!"
```

GHCI notation will look like
```haskell
>>> let a = 1 :: Int
```

## Types

`:t` in GHCI gives the type
```haskell
>>> :t a
a :: Int

>>> :t b
b :: Float

>>> :t c
c :: Char

>>> :t d
d :: [Char]
```

Note that if you don't specify a type, Haskell will choose the most general type:
```haskell
>>> let a = 1

>>> :t a
a :: Num a => a
```

## Lists: Operations

Some useful list operations:

```haskell
>>> let a = [1, 2, 3]
>>> head a
1

>>> tail a
[2, 3]

>>> length a
3

>>> reverse a
[3, 2, 1]
```

## Lists: More operations

More useful list operations:

```haskell
>>> take 2 a
[1, 2]

>>> a !! 2
2

>>> let b = [4, 5, 6]
>>> a ++ b
[1, 2, 3, 4, 5, 6]

>>> 1:[2, 3, 4]
[1, 2, 3, 4]
```

## Lists: Ranges and Infinite Lists

Haskell's laziness allows us to make infinite lists:

```haskell
>>> [1..10]
[1,2,3,4,5,6,7,8,9,10]

>>> [2, 4..10]
[2,4,6,8,10]

>>> take 10 (cycle [1, 2, 3])
[1,2,3,1,2,3,1,2,3,1]

>>> take 10 (repeat 1)
[1,1,1,1,1,1,1,1,1,1]

>>> take 10 [1..]
[1,2,3,4,5,6,7,8,9,10]

>>> let a = 1:a
>>> take 10 a
[1,1,1,1,1,1,1,1,1,1]
```

## List Comprehensions

```haskell
>>> [2 * x | x <- [1..10]]
[2,4,6,8,10,12,14,16,18,20]

>>> [x | x <- [1..20], x `mod` 2 == 0]
[2,4,6,8,10,12,14,16,18,20]

>>> sum [1 | x <- [1..10]]
10
```

Very similar to list comprehensions in Python:

```python
>>> [2 * x for x in range(1, 10)]
[2, 4, 6, 8, 10, 12, 14, 16, 18]
```

## Example: Right Triangles

Generate a list of right triangles that have integer side lengths less than or equal to 10, and that have a perimeter of 24.

## Example: Right Triangles

Generate a list of right triangles that have integer side lengths less than or equal to 10, and that have a perimeter of 24.

```haskell
>>> [[x, y, z] | z <- [1..10], y <- [1..z], x <- [1..y], z * z == x * x + y * y, x + y + z == 24]
[(6,8,10)]
```

Same code but on different lines:

```haskell
[[x, y, z]
   | z <- [1..10], y <- [1..z], x <- [1..y],
     z * z == x * x + y * y,
     x + y + z == 24]
```

## Functions

Our first function, division:

```haskell
div :: Float -> Float -> Float
div a b = a / b
```

## Functions: Infix Functions

Any function can be written using infix notation:

```haskell
>>> 4 `div` 2
2.0

>>> mod 3 2
1

>>> 3 `mod` 2
1

>>> (+) 2 2
4

>>> let (//) a b = a / b
>>> (//) 4 2
2.0

>>> 4 // 2
2.0
```

## Functions

Back to our division function:

```haskell
div :: Float -> Float -> Float
div a b = a / b
```

Where could this implementation go wrong?

## Functions

The imperative programming approach:

```haskell
div :: Float -> Float -> Float
div a b = if b == 0 then error "Divide by zero" else a / b
```

or

```haskell
div :: Float -> Float -> Float
div a b = case b of
    0 -> error "Divide by zero"
    _ -> a / b
```

## Functions: Guards

```haskell
div :: Float -> Float -> Float
div a b
    | b == 0 = error "Divide by zero"
    | otherwise = a / b
```

Note: `otherwise` is equivalent to `True` here.

## Functions: Pattern Matching

```haskell
div :: Float -> Float -> Float
div a 0 = error "Divide by zero"
div a b = a / b
```

## Functions: More pattern matching

We can pattern match any data structure, not just integers:

```haskell
sum :: [Int] -> Int
sum []     = 0
sum (x:xs) = x + sum xs
```

This is better than:
```haskell
sum :: [Int] -> Int
sum [] = 0
sum xs = head xs + sum (tail xs)
```

We can even write:

```haskell
sum :: [Int] -> Int
sum []     = 0
sum [x]    = x
sum [x, y] = x + y
sum (x:xs) = x + sum xs
```

## Functions: Even more pattern matching

We can do this for any data structure (not just lists) thanks to Algebraic Data Types.

Pattern matching on a tree data structure:

```haskell
data Tree = Nil | Node Tree Int Tree

contains :: Tree -> Int -> Bool
contains Nil x = False
contains (Node t1 v t2) x
    | x == v = True
    | x  < v = contains t1 x
    | x  > v = contains t2 x
```

## Functions

Let's take another look at our sum function:

```haskell
sum :: [Int] -> Int
sum []     = 0
sum (x:xs) = x + sum xs
```

What's one problem with this implementation?

## Tail Recursion

```haskell
sum :: [Int] -> Int
sum xs = sumHelper xs 0

sumHelper :: [Int] -> Int -> Int
sumHelper [] soFar = soFar
sumHelper (x:xs) soFar = sumHelper xs (soFar + x)
```

Our original solution now looks ugly and hard to read. Do we always have to trade of readability for speed?

- No, `foldl` and `foldr` can do this for you. Haskell is all about finding common patterns (like tail recursion) and abstracting them.

```
sum :: [Int] -> Int
sum xs = foldl (\acc x -> x + acc) 0 xs
```

## Example: Maximum Element

Find the maximum element of a list. The type signature is shown below:

```haskell
max :: [Int] -> Int
```

You'll want to use pattern matching, guard patterns, and the `error` function when the list is empty.

## Example: Maximum Element

```haskell
max :: [Int] -> Int
max []  = error "Must provide a non-empty list"
max [x] = x
max (x:xs)
  | x > max xs = x
  | otherwise = max xs
```

## Laziness

```haskell
quickSort :: [Int] -> [Int]
quickSort [] = []
quickSort (x:xs) = quickSort (filter (< x) xs) ++ [x] ++ quickSort (filter (>= x) xs)
```

What's the runtime of the following code:
```haskell
>>> head (quickSort [2, 1, 3])
```

## Example: Reversing a list

Given a list of integers, return a list of those integers in reverse order.

## Example: Reversing a list

```haskell
reverse :: [Int] -> [Int]
reverse [] = []
reverse (x:xs) = reverse xs ++ [x]
```

## This Journey 1% Finished

So much more to cover in haskell:

- Currying/Higher order functions
- I/O
- Typeclasses
- Testing
- Monads
- Functors
- Generalized Algebraic Data Types

The list is endless

## Resources

- http://learnyouahaskell.com/chapters
- http://www.haskell.org/haskellwiki/H-99:_Ninety-Nine_Haskell_Problems
- http://book.realworldhaskell.org/

## Questions?
