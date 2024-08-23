module Territorio where

import Tropa

data Territorio = Territorio {
    nome :: String,
    tropas :: [Tropa],
    vizinhos :: [String]
}

