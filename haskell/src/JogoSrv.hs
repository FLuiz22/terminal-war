module JogoSrv where

import Jogador
import Data.Maybe (Maybe(Nothing))
import Continente
import Territorio
import Jogo
import TerritorioSrv


startGame:: Jogo
startGame =
    let americas = Continente {nomeContinente = "Americas", territoriosContinente=["EUA","Canadá","Brasil","Colômbia","Argentina","Chile","México"]}
        europa = Continente {nomeContinente="Europa", territoriosContinente= ["França", "Espanha", "Ucrânia", "Itália"]}
        africa = Continente {nomeContinente="Africa", territoriosContinente= ["Argélia", "Angola", "Egito", "África do Sul", "Madagascar"]}
        asia = Continente {nomeContinente="Asia", territoriosContinente= ["Arábia Saudita", "Irã", "China", "Japão", "Russia", "Índia"]}
        oceania = Continente {nomeContinente="Oceania", territoriosContinente= ["Nova Zelândia","Austrália","Papua Nova-Guiné"]}
        jogador1 = Jogador {quantidadeTerritorios = 3, quantidadeContinentes = 0}
        jogador2 = Jogador {quantidadeTerritorios = 3, quantidadeContinentes = 0}

        ter1 = Territorio { nomeTerritorio = "EUA", vizinhos = ["Canadá", "México", "Japão"], quantidadeDeTropas=2 , dono = 1}
        ter2 = Territorio { nomeTerritorio = "Canadá", vizinhos = ["Eua", "México", "França"],quantidadeDeTropas=2, dono = 1}
        ter3 = Territorio { nomeTerritorio = "Brasil", vizinhos = ["Argentina", "Colômbia", "Angola"],quantidadeDeTropas =0, dono = 3}
        ter4 = Territorio { nomeTerritorio = "Colômbia", vizinhos = ["Chile", "Brasil", "Argentina", "México"],quantidadeDeTropas=0, dono = 3}
        ter5 = Territorio { nomeTerritorio = "Argentina", vizinhos = ["Chile", "Brasil", "Colômbia"],quantidadeDeTropas=0, dono = 3}
        ter6 = Territorio { nomeTerritorio = "Chile", vizinhos = ["Argentina", "Colômbia"],quantidadeDeTropas=0, dono = 3}
        ter7 = Territorio { nomeTerritorio = "México", vizinhos = ["EUA", "Colômbia"],quantidadeDeTropas=2, dono = 1}
        ter8 = Territorio { nomeTerritorio = "Espanha", vizinhos = ["França","Italia"],quantidadeDeTropas=0, dono = 3}
        ter9 = Territorio { nomeTerritorio = "Itália", vizinhos = ["França","Espanha","Ucrânia"],quantidadeDeTropas=0, dono = 3}
        ter10 = Territorio { nomeTerritorio = "Ucrânia", vizinhos = ["França","Itália","Rússia"],quantidadeDeTropas=0, dono = 3}
        ter11 = Territorio { nomeTerritorio = "França", vizinhos = ["Espanha","França","Ucrânia","Canadá"],quantidadeDeTropas=0, dono = 3}
        ter12 = Territorio { nomeTerritorio = "Egito", vizinhos = ["Arábia Saudita","Angola","Argélia"],quantidadeDeTropas=0, dono = 3}
        ter13 = Territorio { nomeTerritorio = "África do Sul", vizinhos = ["Angola","Madagascar"],quantidadeDeTropas=0, dono = 3}
        ter14 = Territorio { nomeTerritorio = "Angola", vizinhos = ["Africa do Sul","Egito","Argélia","Brasil"],quantidadeDeTropas=0, dono = 3}
        ter15 = Territorio { nomeTerritorio = "Argélia", vizinhos = ["Itália","Espanha","Egito","Angola"],quantidadeDeTropas=0, dono = 3}
        ter16 = Territorio { nomeTerritorio = "Madagascar", vizinhos = ["África do Sul","Austrália"],quantidadeDeTropas=0, dono = 3}
        ter17 = Territorio { nomeTerritorio = "Arábia Saudita", vizinhos = ["Egito", "Irã", "Índia"],quantidadeDeTropas=0, dono = 3}
        ter18 = Territorio { nomeTerritorio = "Irã", vizinhos = ["Arábia Saudita", "Índia"],quantidadeDeTropas=0, dono = 3}
        ter19 = Territorio { nomeTerritorio = "China", vizinhos = ["Índia", "Japão", "Russia", "Austrália"],quantidadeDeTropas=2, dono = 2}
        ter20 = Territorio { nomeTerritorio = "Japão", vizinhos = ["China", "Russia", "Papua Nova-Guiné", "EUA"],quantidadeDeTropas=0, dono = 3}
        ter21 = Territorio { nomeTerritorio = "Russia", vizinhos = ["Ucrânia", "Irã", "China", "Índia", "Japão"],quantidadeDeTropas=2, dono = 2}
        ter22 = Territorio { nomeTerritorio = "Índia", vizinhos = ["Arábia Saudita", "China", "Irã", "Russia"],quantidadeDeTropas=2, dono = 2}
        ter23 = Territorio { nomeTerritorio = "Nova Zelândia", vizinhos = ["Austrália"],quantidadeDeTropas=0, dono = 3}
        ter24 = Territorio { nomeTerritorio = "Austrália", vizinhos = ["Nova Zelândia", "Papua Nova-Guiné","China","Madagascar"],quantidadeDeTropas=0, dono = 3}
        ter25 = Territorio { nomeTerritorio = "Papua Nova-Guiné", vizinhos = ["Austrália", "Japão"],quantidadeDeTropas=0, dono = 3}

    in  Jogo {continentes = [americas,europa,africa,asia,oceania],territorios=[ter1, ter2, ter3, ter4, ter5, ter6, ter7, ter8, ter9, ter10, ter11, ter12,
     ter13, ter14, ter15, ter16, ter17, ter18, ter19, ter20, ter21, ter22, ter23, ter24, ter25], jogadores=(jogador1,jogador2)}


verificaVitoria :: Jogador -> Jogador -> Maybe Jogador
verificaVitoria jogador1 jogador2
    | quantidadeTerritorios jogador1 == 0 && quantidadeTerritorios jogador2 > 0 =  Just jogador2
    | quantidadeTerritorios jogador2 == 0 && quantidadeTerritorios jogador1 > 0 = Just jogador1
    | quantidadeContinentes jogador1 >= 2 && quantidadeContinentes jogador2 < 2 = Just jogador2
    | quantidadeContinentes jogador2 >= 2 && quantidadeContinentes jogador1 < 2 = Just jogador1
    | otherwise = Nothing

<<<<<<< HEAD
achaTerritoriosDeJogador :: Jogo ->  Int -> [String]
achaTerritoriosDeJogador jogo jogador =

    let lista = territorios jogo
    in map nomeTerritorio (filter (\t -> dono t == jogador) lista)
=======
-- Funcao que retorna os territorios de um jogador especifico, 1 ou 2
achaTerritoriosDeJogador :: Jogo ->  Int -> [Territorio]
achaTerritoriosDeJogador jogo jogador =
    let lista = territorios jogo
    in filter (\t -> dono t == jogador) lista
>>>>>>> main

verficaTropaJg :: Territorio -> Int -> Bool
verficaTropaJg ter idJogador = idJogador == dono ter

verficaVizinhos :: String -> [String] -> Bool
verficaVizinhos _ [] = False
verficaVizinhos nomeTer (x:xs)
    | nomeTer == x = True
    | otherwise = verficaVizinhos nomeTer xs

moverTropaSrv :: Territorio -> Territorio -> Int -> Maybe [Territorio]
moverTropaSrv ter1 ter2 qntd = if quantidadeTropas ter1 - qntd <= 0 ||
    not (verficaVizinhos (nomeTerritorio ter2) (vizinhos ter1)) || not (verficaTropaJg ter2 (dono ter1))
    then Nothing

    else Just (moverTropa ter1 ter2 qntd)