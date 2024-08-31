module JogoCtrl where

import JogoSrv
import TerritorioSrv
import Territorio
import Jogador
import Continente
<<<<<<< HEAD
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
=======
import Jogo
import JogoSrv
import Data.Maybe
>>>>>>> main

-- Verifica caso um jogador já tenha vencido, se sim, o jogador será retornado, se nao, será retornado Nothing
verificaVitoriaCtrl :: Jogador -> Jogador -> Maybe Jogador
verificaVitoriaCtrl jogador1 jogador2 = verificaVitoria jogador1 jogador2

-- Inicia um jogo, é definido os continentes, os jogadores, e os territorios de cada continente
<<<<<<< HEAD
startGameCtrl :: Jogo 
startGameCtrl = startGame

-- Funcao que retorna os territorios de um jogador especifico, 1 ou 2
achaTerritoriosDeJogadorCtrl :: Jogo ->  Int -> [String]
achaTerritoriosDeJogadorCtrl jogo jogador = achaTerritoriosDeJogador jogo jogador
=======
startGame:: Jogo
startGame =
    let americas = Continente {nomeContinente = "Americas", territoriosContinente=["EUA","Canadá","Brasil","Colômbia","Argentina","Chile","México"]}
        europa = Continente {nomeContinente="Europa", territoriosContinente= ["França", "Espanha", "Ucrânia", "Itália"]}
        africa = Continente {nomeContinente="Africa", territoriosContinente= ["Argélia", "Angola", "Egito", "África do Sul", "Madagascar"]}
        asia = Continente {nomeContinente="Asia", territoriosContinente= ["Arábia Saudita", "Irã", "China", "Japão", "Russia", "Índia"]}
        oceania = Continente {nomeContinente="Oceania", territoriosContinente= ["Nova Zelândia","Austrália","Papua Nova-Guiné"]}
        jogador1 = Jogador {quantidadeTerritorios = 5, quantidadeContinentes = 0}
        jogador2 = Jogador {quantidadeTerritorios = 5, quantidadeContinentes = 0}
    in  Jogo {continentes = [americas,europa,africa,asia,oceania], jogadores=(jogador1,jogador2)}

    where
        ter1 = Territorio { nomeTerritorio = "EUA", vizinhos = ["Canadá", "México", "Japão"], dono = 3}
        ter2 = Territorio { nomeTerritorio = "Canadá", vizinhos = ["Eua", "México", "França"], dono = 3}
        ter3 = Territorio { nomeTerritorio = "Brasil", vizinhos = ["Argentina", "Colômbia", "Angola"], dono = 3}
        ter4 = Territorio { nomeTerritorio = "Colômbia", vizinhos = ["Chile", "Brasil", "Argentina", "México"], dono = 3}
        ter5 = Territorio { nomeTerritorio = "Argentina", vizinhos = ["Chile", "Brasil", "Colômbia"], dono = 3}
        ter6 = Territorio { nomeTerritorio = "Chile", vizinhos = ["Argentina", "Colômbia"], dono = 3}
        ter7 = Territorio { nomeTerritorio = "México", vizinhos = ["EUA", "Colômbia"], dono = 3}
        ter8 = Territorio { nomeTerritorio = "Espanha", vizinhos = ["França","Italia"], dono = 3}
        ter9 = Territorio { nomeTerritorio = "Itália", vizinhos = ["França","Espanha","Ucrânia"], dono = 3}
        ter10 = Territorio { nomeTerritorio = "Ucrânia", vizinhos = ["França","Itália","Rússia"], dono = 3}
        ter11 = Territorio { nomeTerritorio = "França", vizinhos = ["Espanha","França","Ucrânia","Canadá"], dono = 3}
        ter12 = Territorio { nomeTerritorio = "Egito", vizinhos = ["Arábia Saudita","Angola","Argélia"], dono = 3}
        ter13 = Territorio { nomeTerritorio = "África do Sul", vizinhos = ["Angola","Madagascar"], dono = 3}
        ter14 = Territorio { nomeTerritorio = "Angola", vizinhos = ["Africa do Sul","Egito","Argélia","Brasil"], dono = 3}
        ter15 = Territorio { nomeTerritorio = "Argélia", vizinhos = ["Itália","Espanha","Egito","Angola"], dono = 3}
        ter16 = Territorio { nomeTerritorio = "Madagascar", vizinhos = ["África do Sul","Austrália"], dono = 3}
        ter17 = Territorio { nomeTerritorio = "Arábia Saudita", vizinhos = ["Egito", "Irã", "Índia"], dono = 3}
        ter18 = Territorio { nomeTerritorio = "Irã", vizinhos = ["Arábia Saudita", "Índia"], dono = 3}
        ter19 = Territorio { nomeTerritorio = "China", vizinhos = ["Índia", "Japão", "Russia", "Austrália"], dono = 3}
        ter20 = Territorio { nomeTerritorio = "Japão", vizinhos = ["China", "Russia", "Papua Nova-Guiné", "EUA"], dono = 3}
        ter21 = Territorio { nomeTerritorio = "Russia", vizinhos = ["Ucrânia", "Irã", "China", "Índia", "Japão"], dono = 3}
        ter22 = Territorio { nomeTerritorio = "Índia", vizinhos = ["Arábia Saudita", "China", "Irã", "Russia"], dono = 3}
        ter23 = Territorio { nomeTerritorio = "Nova Zelândia", vizinhos = ["Austrália"], dono = 3}
        ter24 = Territorio { nomeTerritorio = "Austrália", vizinhos = ["Nova Zelândia", "Papua Nova-Guiné","China","Madagascar"], dono = 3}
        ter25 = Territorio { nomeTerritorio = "Papua Nova-Guiné", vizinhos = ["Austrália", "Japão"], dono = 3}

-- Funcao que retorna os territorios de um jogador especifico, 1 ou 2
achaTerritoriosDeJogador :: Jogo ->  Int -> [String]
achaTerritoriosDeJogador jogo jogador =

    let lista = territorios jogo
    in map nomeTerritorio (filter (\t -> dono t == jogador) lista)

moverTropaCtrl :: Territorio -> Territorio -> Int -> Bool
moverTropaCtrl ter1 ter2 qntd = isJust (moverTropaSrv ter1 ter2 qntd)
>>>>>>> main
