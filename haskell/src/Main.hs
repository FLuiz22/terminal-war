module Main where

import TerritorioSrv
import Territorio
import Tropa

main :: IO ()
main = do
    let tropa = Tropa { jogador = 1 }
    let ter = Territorio { nome = "T1", tropas = [tropa], vizinhos = []}

    print(length (tropas (removeTropa ter)))
    print(length (tropas (adicionaTropa ter [tropa])))