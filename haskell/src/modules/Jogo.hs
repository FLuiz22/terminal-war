module Jogo where

{-
    Jogo: struct do jogo contendo os territórios,
          continentes e os jogadores.
-}

import Continente
import Jogador
import Territorio

data Jogo = Jogo {
    continentes :: [Continente],
    territorios :: [Territorio],
    jogadores :: (Jogador, Jogador)
}


