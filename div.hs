div :: Float -> Float -> Float
div a b = a / b

div' :: Float -> Float -> Float
div' a b = if b == 0 then error "Divide by zero" else a / b

div'' :: Float -> Float -> Float
div'' a b = case b of
    0 -> error "Divide by zero"
    _ -> a / b

div''' :: Float -> Float -> Float
div''' a b
    | b == 0 = error "Divide by zero"
    | otherwise = a / b

div'''' :: Float -> Float -> Float
div'''' a 0 = error "Divide by zero"
div'''' a b = a / b
