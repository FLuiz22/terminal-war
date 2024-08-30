module JogoCtrl where

import TerritorioSrv
import Territorio
import Jogador
import Jogo

verficaTropaJg :: Tropa -> Int -> Bool
verficaTropaJg tropa idJogador = if idJogador == (jogador tropa) then True else False

verficaVizinhos :: String -> [String] -> Bool
verficaVizinhos _ [] = False
verficaVizinhos nomeTer (x:xs)
    | nomeTer == x = True
    | otherwise = verficaVizinhos nomeTer xs

-- Retorno da função temporário
moverTropaCtrl :: Territorio -> Territorio -> Int -> Int -> Maybe [Territorio]
moverTropaCtrl ter1 ter2 qntd idJogador = if (length (tropas ter1)) - qntd <= 0 || 
    not (verficaVizinhos (nome ter2) (vizinhos ter1)) || not (verficaTropaJg (head (tropas ter2)) idJogador)
    then Nothing

    else Just (moverTropa ter1 ter2 qntd)