module JogoSrv where

{-
    Jogo Service: Responsável por conter as funções referentes
                  ao Jogo.
-}

import Jogador
import Data.Maybe (Maybe(Nothing))
import Continente
import Territorio
import Jogo
import TerritorioSrv
import Data.List

{-
    Seta todos os territórios, continentes, jogagadores e suas relações.
-}
startGame:: Jogo
startGame =
    let americas = Continente {nomeContinente = "Americas", territoriosContinente=["EUA","CAN","BR","CO","ARG","CL","MX"]}
        europa = Continente {nomeContinente="Europa", territoriosContinente= ["FR", "ES", "UA", "IT"]}
        africa = Continente {nomeContinente="Africa", territoriosContinente= ["DZ", "AGO", "EG", "RSA", "MG"]}
        asia = Continente {nomeContinente="Asia", territoriosContinente= ["SA", "IR", "CN", "JP", "RUS", "IN"]}
        oceania = Continente {nomeContinente="Oceania", territoriosContinente= ["NZ","AU","PNG"]}
        jogador1 = Jogador {quantidadeTerritorios = 3, quantidadeContinentes = 2}
        jogador2 = Jogador {quantidadeTerritorios = 3, quantidadeContinentes = 0}

        ter1 = Territorio { nomeTerritorio = "EUA", vizinhos = ["CAN", "MX", "JP"], quantidadeDeTropas=2 , dono = 1}
        ter2 = Territorio { nomeTerritorio = "CAN", vizinhos = ["EUA", "MX", "FR"],quantidadeDeTropas=2, dono = 1}
        ter3 = Territorio { nomeTerritorio = "BR", vizinhos = ["ARG", "CO", "AGO"],quantidadeDeTropas = 1, dono = 1}
        ter4 = Territorio { nomeTerritorio = "CO", vizinhos = ["CL", "BR", "ARG", "MX"],quantidadeDeTropas= 1, dono = 1}
        ter5 = Territorio { nomeTerritorio = "ARG", vizinhos = ["CL", "BR", "CO"],quantidadeDeTropas=1, dono = 1}
        ter6 = Territorio { nomeTerritorio = "CL", vizinhos = ["ARG", "CO"],quantidadeDeTropas=1, dono = 1}
        ter7 = Territorio { nomeTerritorio = "MX", vizinhos = ["EUA", "CO"],quantidadeDeTropas=2, dono = 1}

        ter8 = Territorio { nomeTerritorio = "ES", vizinhos = ["FR","IT"],quantidadeDeTropas=1, dono = 3}
        ter9 = Territorio { nomeTerritorio = "IT", vizinhos = ["FR","ES","UA"],quantidadeDeTropas=1, dono = 3}
        ter10 = Territorio { nomeTerritorio = "UA", vizinhos = ["FR","IT","RUS"],quantidadeDeTropas=1, dono = 3}
        ter11 = Territorio { nomeTerritorio = "FR", vizinhos = ["ES","UA","CAN"],quantidadeDeTropas=1, dono = 3}

        ter12 = Territorio { nomeTerritorio = "EG", vizinhos = ["SA","AGO","DZ"],quantidadeDeTropas=1, dono = 3}
        ter13 = Territorio { nomeTerritorio = "RSA", vizinhos = ["AGO","MG"],quantidadeDeTropas=1, dono = 3}
        ter14 = Territorio { nomeTerritorio = "AGO", vizinhos = ["RSA","EG","DZ","BR"],quantidadeDeTropas=1, dono = 3}
        ter15 = Territorio { nomeTerritorio = "DZ", vizinhos = ["IT","ES","EG","AGO"],quantidadeDeTropas=1, dono = 3}
        ter16 = Territorio { nomeTerritorio = "MG", vizinhos = ["RSA","AU"],quantidadeDeTropas=1, dono = 3}
        
        ter17 = Territorio { nomeTerritorio = "SA", vizinhos = ["EG", "IR", "IN"],quantidadeDeTropas=1, dono = 3}
        ter18 = Territorio { nomeTerritorio = "IR", vizinhos = ["SA", "IN"],quantidadeDeTropas=1, dono = 3}
        ter19 = Territorio { nomeTerritorio = "CN", vizinhos = ["IN", "JP", "RUS", "AU"],quantidadeDeTropas=2, dono = 2}
        ter20 = Territorio { nomeTerritorio = "JP", vizinhos = ["CN", "RUS", "PNG", "EUA"],quantidadeDeTropas=1, dono = 3}
        ter21 = Territorio { nomeTerritorio = "RUS", vizinhos = ["UA", "IR", "CN", "IN", "JP"],quantidadeDeTropas=2, dono = 2}
        ter22 = Territorio { nomeTerritorio = "IN", vizinhos = ["SA", "CN", "IR", "RUS"],quantidadeDeTropas=2, dono = 2}
        
        ter23 = Territorio { nomeTerritorio = "NZ", vizinhos = ["AU"],quantidadeDeTropas=1, dono = 1}
        ter24 = Territorio { nomeTerritorio = "AU", vizinhos = ["NZ", "PNG","CN","MG"],quantidadeDeTropas=1, dono = 1}
        ter25 = Territorio { nomeTerritorio = "PNG", vizinhos = ["AU", "JP"],quantidadeDeTropas=1, dono = 1}

        {-Americas = 15
        Europa = 11
        Asia = 15
        Africa = 16
        Oceania = 18-}

    in  Jogo {continentes = [americas,europa,africa,asia,oceania],territorios=[ter1, ter2, ter3, ter4, ter5, ter6, ter7, ter8, ter9, ter10, ter11, ter12,
     ter13, ter14, ter15, ter16, ter17, ter18, ter19, ter20, ter21, ter22, ter23, ter24, ter25], jogadores=(jogador1,jogador2)}

{-
    Verifica se as condições de vitória foram alcançadas por algum dos jogadores, ou seja,
    verifica se um jogador conquistou dois continentes ou se o jogador inimigo está sem territórios.
-}
verificaVitoria :: Jogador -> Jogador -> Maybe String
verificaVitoria jogador1 jogador2
    | quantidadeTerritorios jogador1 == 0 && quantidadeTerritorios jogador2 > 0 =  Just "Jogador 2"
    | quantidadeTerritorios jogador2 == 0 && quantidadeTerritorios jogador1 > 0 = Just "Jogador 1"
    | quantidadeContinentes jogador1 >= 2 && quantidadeContinentes jogador2 < 2 = Just "Jogador 1"
    | quantidadeContinentes jogador2 >= 2 && quantidadeContinentes jogador1 < 2 = Just "Jogador 2"
    | otherwise = Nothing


{-
    Retorna uma lista com o nome dos territórios de um jogador.
-}
achaTerritoriosDeJogador :: Jogo ->  Int -> [String]
achaTerritoriosDeJogador jogo jogador =

    let lista = territorios jogo
    in map nomeTerritorio (filter (\t -> dono t == jogador) lista)

{-
    Verifica se um jogador é dono de um território.
-}
verificaTerritorioJgr :: Territorio -> Int -> Bool
verificaTerritorioJgr ter idJogador = idJogador == dono ter

{-
    Verifica se dois territórios são considerados vizinhos.
-}
verificaVizinhos :: String -> [String] -> Bool
verificaVizinhos _ [] = False
verificaVizinhos nomeTer (x:xs)
    | nomeTer == x = True
    | otherwise = verificaVizinhos nomeTer xs

{-
    Move tropas de um território para outro, contanto que os dois sejam vizinhos e sejam dominados pelo mesmo jogador.
-}
moverTropaSrv :: Territorio -> Territorio -> Int -> Maybe [Territorio]
moverTropaSrv ter1 ter2 qntd = if quantidadeDeTropas ter1 - qntd <= 0 ||
    not (verificaVizinhos (nomeTerritorio ter2) (vizinhos ter1)) || not (verificaTerritorioJgr ter2 (dono ter1))
    then Nothing

    else Just (moverTropa ter1 ter2 qntd)

{-
    Recebe uma lista de nomes de territórios, compara com os territórios de um continente e retorna a lista com o nome dos territórios
    que estão na lista passada e que são do continente passado. 
-}
verificaDomCont :: Continente -> [String] -> [String]
verificaDomCont cont ters = [x |
                                x <- territoriosContinente cont,
                                y <- ters,
                                x == y
                            ]

{-
    Atualiza a quantidade de continentes dominados pelo jogador.
-}
atualizaContJogador :: Jogador -> Int -> Jogador
atualizaContJogador jg incremento = Jogador {  quantidadeTerritorios = quantidadeTerritorios jg,
                                    quantidadeContinentes = quantidadeContinentes jg + incremento}

{-
    Atualiza a quantidade de territórios dominados pelo jogador.
-}
atualizaTerJogador :: Jogador -> Jogo -> Int -> Jogador
atualizaTerJogador jgdor jogo idJogador = Jogador {  quantidadeTerritorios = length (achaTerritoriosDeJogador jogo idJogador),
                                                quantidadeContinentes = quantidadeContinentes jgdor}

{-
    Retorna a quantidade de tropas recebidas pelo jogador no inicio da rodada, com auxílio da função calculaTropas.
-}
recebeTropas :: Jogo -> Int -> Int
recebeTropas jogo player
    | n_terr > 0 = calculaTropas n_terr
    | otherwise = 0
    where n_terr = length(achaTerritoriosDeJogador jogo player)

{-
    Calcula quantas tropas o jogador recebe no inicio da rodada com base na quantiade de territorios que ele possui.
-}
calculaTropas :: Int -> Int
calculaTropas x = x `div` 2

{-
    Distribui uma quantidade x de tropas para um território do jogador.
-}
distribuiTropas :: Int -> Int -> Territorio -> Maybe Territorio
distribuiTropas player n_tropas terr
    | verificaTerritorioJgr terr player = Just (adicionaTropa terr n_tropas)
    | otherwise = Nothing

{-
    Retorna o território com o mesmo nome passado.
-}
getTerritorio :: [Territorio] -> String -> Maybe Territorio
getTerritorio [] _ = Nothing
getTerritorio (x:xs) nomeTerr 
    | nomeTerritorio x == nomeTerr = Just x
    | otherwise = getTerritorio xs nomeTerr

