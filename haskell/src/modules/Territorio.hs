module Territorio where

data Territorio = Territorio {
    nomeTerritorio :: String,
    vizinhos :: [String],
    dono :: Int
}

