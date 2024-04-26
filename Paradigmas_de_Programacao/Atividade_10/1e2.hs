data Expr = Val Float | Div Expr Expr | Mult Expr Expr | Add Expr Expr | Sub Expr Expr | Sqrt Expr deriving (Show, Eq)

myDiv :: Float -> Float -> Maybe Float
myDiv a b | (b == 0) = Nothing
          | otherwise = Just (a / b)

myMult :: Float -> Float -> Maybe Float
myMult a b = Just (a * b)

myAdd :: Float -> Float -> Maybe Float
myAdd a b = Just (a + b)

mySub :: Float -> Float -> Maybe Float
mySub a b = Just (a - b)

mySqrt :: Float -> Maybe Float
mySqrt a | (a < 0) = Nothing
         | otherwise = Just (a**(1/2))

eval :: Expr -> Maybe Float
eval (Val a) = Just a
eval (Div a b) =
    case (eval a) of
        Nothing -> Nothing
        Just a -> case (eval b) of
            Nothing -> Nothing
            (Just b) -> myDiv a b
eval (Mult a b) =
    case (eval a) of
        Nothing -> Nothing
        Just a -> case (eval b) of
            Nothing -> Nothing
            Just b -> myMult a b
eval (Add a b) =
    case (eval a) of
        Nothing -> Nothing
        Just a -> case (eval b) of
            Nothing -> Nothing
            Just b -> myAdd a b
eval (Sub a b) =
    case (eval a) of
        Nothing -> Nothing
        Just a -> case (eval b) of
            Nothing -> Nothing
            Just b -> mySub a b
eval (Sqrt a) =
    case (eval a) of
        Nothing -> Nothing
        Just a -> mySqrt a

evalBind :: Expr -> Maybe Float
evalBind (Val n) = return n 
evalBind (Div a b) =
    evalBind a >>=
        (\a -> evalBind b >>=
            (\b -> myDiv a b))
evalBind (Mult a b) =
    evalBind a >>=
        (\a -> evalBind b >>=
            (\b -> myMult a b))
evalBind (Add a b) =
    evalBind a >>=
        (\a -> evalBind b >>=
            (\b -> myAdd a b))
evalBind (Sub a b) =
    evalBind a >>=
        (\a -> evalBind b >>=
            (\b -> mySub a b))
evalBind (Sqrt a) =
    evalBind a >>=
        (\a -> mySqrt a)

evalDo :: Expr -> Maybe Float
evalDo (Val a) = return a
evalDo (Div a b) = do
    a <- evalDo a
    b <- evalDo b
    myDiv a b
evalDo (Mult a b) = do
    a <- evalDo a
    b <- evalDo b
    myMult a b
evalDo (Add a b) = do
    a <- evalDo a
    b <- evalDo b
    myAdd a b
evalDo (Sub a b) = do
    a <- evalDo a
    b <- evalDo b
    mySub a b
evalDo (Sqrt a) = do
    a <- evalDo a
    mySqrt a

main = do
    print (eval (Div (Val 5) (Val 0)))
    print (eval (Mult (Val 5) (Val 5)))
    print (eval (Add (Val 5) (Val 2)))
    print (eval (Sub (Val 5) (Val 6)))
    print (eval (Sqrt (Val 4)))

    print (evalBind (Div (Val 5) (Val 0)))
    print (evalBind (Mult (Val 5) (Val 5)))
    print (evalBind (Add (Val 5) (Val 2)))
    print (evalBind (Sub (Val 5) (Val 6)))
    print (evalBind (Sqrt (Val 4)))

    print (evalDo (Div (Val 5) (Val 0)))
    print (evalDo (Mult (Val 5) (Val 5)))
    print (evalDo (Add (Val 5) (Val 2)))
    print (evalDo (Sub (Val 5) (Val 6)))
    print (evalDo (Sqrt (Val 4)))

