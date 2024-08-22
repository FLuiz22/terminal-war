module Jogo where

import Continente
import Jogador

data Jogo = Jogo {
    continentes :: [Continente],
    jogadores :: (Jogador, Jogador)
}

