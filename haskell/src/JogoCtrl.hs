module JogoCtrl where

import JogoSrv
import TerritorioSrv
import Territorio
import Jogador
import Continente
import Jogo
import JogoSrv
import Data.Maybe

-- Verifica caso um jogador já tenha vencido, se sim, o jogador será retornado, se nao, será retornado Nothing
verificaVitoriaCtrl :: Jogador -> Jogador -> Maybe Jogador
verificaVitoriaCtrl jogador1 jogador2 = verificaVitoria jogador1 jogador2

-- Inicia um jogo, é definido os continentes, os jogadores, e os territorios de cada continente
startGameCtrl :: Jogo 
startGameCtrl = startGame

-- Funcao que retorna os territorios de um jogador especifico, 1 ou 2
achaTerritoriosDeJogadorCtrl :: Jogo ->  Int -> [String]
achaTerritoriosDeJogadorCtrl jogo jogador = achaTerritoriosDeJogador jogo jogador

moverTropaCtrl :: Territorio -> Territorio -> Int -> Bool
moverTropaCtrl ter1 ter2 qntd = isJust (moverTropaSrv ter1 ter2 qntd)
