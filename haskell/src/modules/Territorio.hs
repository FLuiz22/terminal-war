module Territorio where

import Tropa

data Territorio = Territorio {
    nome :: String,
    tropas :: [Tropa],
    vizinhos :: [Territorio]
}

