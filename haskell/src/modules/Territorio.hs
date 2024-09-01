module Territorio where

{-
    Territorio: struct base para um território contendo o nome,
                os vizinhos, a quantidade de tropas e o código
                do dono.
-}

data Territorio = Territorio {
    nomeTerritorio :: String,
    vizinhos :: [String],
    quantidadeDeTropas :: Int,
    dono :: Int
}
