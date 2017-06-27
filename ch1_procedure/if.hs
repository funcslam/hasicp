module If where

{-
 - if function implementation.
 - If predicate satisfies true, then evaluate consequent.
 - If not, evaluate alternative.
 -}

-- if' predicate consequent alternative
if' :: Bool -> a -> a -> a
if' True  c _ = c
if' False _ a = a

-- infix version of if'
(?) :: Bool -> a -> a -> a
(?) = if'
