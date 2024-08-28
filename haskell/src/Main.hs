module Main where

import Territorio
import Tropa
import JogoCtrl
import Util

main :: IO ()
main = do
    let tropa = Tropa { jogador = 1 }
    let ter = Territorio { nome = "T1", tropas = [tropa, tropa], vizinhos = ["T2"]}
    let ter2 = Territorio { nome = "T2", tropas = [tropa], vizinhos = ["T1"]}
    let ter2N = maybeToList (moverTropaCtrl ter ter2 1 1)

    print(length (tropas (head ter2N)))
    print(length (tropas (last ter2N)))