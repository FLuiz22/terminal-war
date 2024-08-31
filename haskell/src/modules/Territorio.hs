module Territorio where

data Territorio = Territorio {
    nomeTerritorio :: String,
    vizinhos :: [String],
    quantidadeTropas :: Int,
    dono :: Int
}
