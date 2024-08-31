module Jogo where

import Continente
import Jogador
import Territorio

data Jogo = Jogo {
    continentes :: [Continente],
    territorios :: [Territorio],
    jogadores :: (Jogador, Jogador)
}


