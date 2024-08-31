module Main where

import Territorio
import JogoCtrl
import Util
import Jogo 
import Jogador





main :: IO ()
main = do
  
    let ter = Territorio { nomeTerritorio = "T1", vizinhos = ["T2"], dono=1}
    let ter2 = Territorio { nomeTerritorio = "T2", vizinhos = ["T1"],dono = 3}
    let jogador1 = Jogador {quantidadeTerritorios=1,quantidadeContinentes=0}
    let jogador2 = Jogador {quantidadeTerritorios=0,quantidadeContinentes=0}
    let jogo = Jogo {territorios=[ter,ter2]}

    -- let ter2N = maybeToList (moverTropaCtrl ter ter2 1 1)
    let listaTerritorios =  achaTerritoriosDeJogador jogo 1 
    
   
    print(listaTerritorios)
    -- print(length (tropas (head ter2N)))
    -- print(length (tropas (last ter2N)))