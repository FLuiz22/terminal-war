module Main where

import Territorio
import JogoCtrl
import Util
import Jogo 
import Jogador
import Territorio (Territorio(quantidadeTropas))

main :: IO ()
main = do
  
    let ter = Territorio { nomeTerritorio = "T1", vizinhos = ["T2"], dono=1, quantidadeTropas = 1}
    let ter2 = Territorio { nomeTerritorio = "T2", vizinhos = ["T1", "T3"], dono = 3, quantidadeTropas = 2}
    let ter3 = Territorio { nomeTerritorio = "T3", vizinhos = ["T2"], dono = 3, quantidadeTropas = 2}
    let jogador1 = Jogador {quantidadeTerritorios=1,quantidadeContinentes=0}
    let jogador2 = Jogador {quantidadeTerritorios=0,quantidadeContinentes=0}
    let jogo = Jogo {territorios=[ter,ter2]}

    let listaTerritorios =  achaTerritoriosDeJogador jogo 1 
   
    print(listaTerritorios)

    print(moverTropaCtrl ter ter2 1)
    print(moverTropaCtrl ter2 ter3 1)