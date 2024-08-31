module JogoCtrl where

import JogoSrv
import TerritorioSrv
import Territorio
import Jogador
import Jogo
import Continente
import Jogador (Jogador(quantidadeTerritorios, quantidadeContinentes))
import Jogo (Jogo(jogadores))


-- verficaTropaJg :: Tropa -> Int -> Bool
-- verficaTropaJg tropa idJogador = if idJogador == (jogador tropa) then True else False

verficaVizinhos :: String -> [String] -> Bool
verficaVizinhos _ [] = False
verficaVizinhos nomeTer (x:xs)
    | nomeTer == x = True
    | otherwise = verficaVizinhos nomeTer xs

-- Retorno da função temporário
-- moverTropaCtrl :: Territorio -> Territorio -> Int -> Int -> Maybe [Territorio]
-- moverTropaCtrl ter1 ter2 qntd idJogador = if (length (tropas ter1)) - qntd <= 0 || 
--     not (verficaVizinhos (nome ter2) (vizinhos ter1)) || not (verficaTropaJg (head (tropas ter2)) idJogador)
--     then Nothing

--     else Just (moverTropa ter1 ter2 qntd)

-- Verifica caso um jogador já tenha vencido, se sim, o jogador será retornado, se nao, será retornado Nothing
verificaVitoriaCtrl :: Jogador -> Jogador -> Maybe Jogador
verificaVitoriaCtrl jogador1 jogador2 = verificaVitoria jogador1 jogador2

-- Inicia um jogo, é definido os continentes, os jogadores, e os territorios de cada continente
startGameCtrl :: Jogo 
startGameCtrl = startGame

-- Funcao que retorna os territorios de um jogador especifico, 1 ou 2
achaTerritoriosDeJogadorCtrl :: Jogo ->  Int -> [String]
achaTerritoriosDeJogadorCtrl jogo jogador = achaTerritoriosDeJogador jogo jogador