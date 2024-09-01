module Continente where

{-
    Continente: struct do continente, responsável por
                guardar o nome do continente e o nome
                dos território que fazem parte dele.
-}

data Continente  = Continente {
    nomeContinente :: String,
    territoriosContinente :: [String]
}