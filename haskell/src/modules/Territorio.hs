module Territorio where

data Territorio = Territorio {
    nomeTerritorio :: String,
    vizinhos :: [String],
    quantidadeDeTropas :: Int,
    dono :: Int
}
