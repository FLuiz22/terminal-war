module Main where

import TerritorioSrv
import Territorio
import Tropa



main :: IO ()
main = do
    let tropa = Tropa { jogador = 1 }
    let ter = Territorio { nome = "T1", tropas = [tropa], vizinhos = []}
    let ter2 = Territorio { nome = "T2", tropas = [tropa], vizinhos = []}
    let ter2N = moverTropa ter ter2 1

    print(length (tropas (fst (ter2N))))
    print(length (tropas (snd (ter2N))))