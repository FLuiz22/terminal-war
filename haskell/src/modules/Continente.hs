module Continente where

import Territorio

data Continente  = Continente {
    nome :: String,
    territorios :: [Territorio]
}