module JogoCtrl where

{-
    JogoCtrl: Responsável por reunir as funções dos services e realizar
              algumas operações de efeito colateral.
-}

import TerritorioSrv
import Territorio
import Jogador
import Continente
import Jogo
import JogoSrv
import Data.Maybe
import Util
import Data.List

{-
    verificaVitoriaCtrl: Verifica caso um jogador já tenha vencido, se sim, 
                         o jogador será retornado, se nao, será retornado Nothing.
-}
verificaVitoriaCtrl :: Jogador -> Jogador -> String
verificaVitoriaCtrl jogador1 jogador2
    | isJust (verificaVitoria jogador1 jogador2) = maybeToString (verificaVitoria jogador1 jogador2)
    | otherwise = ""

{-
    startGameCtrl: Inicia um jogo, é definido os continentes, 
                   os jogadores, e os territorios de cada continente
-}

startGameCtrl :: Jogo
startGameCtrl = startGame

{-
    achaTerritoriosDeJogadorCtrl: Função que retorna os territorios 
                                  de um jogador especifico, 1 ou 2.
-}

achaTerritoriosDeJogadorCtrl :: Jogo ->  Int -> [String]
achaTerritoriosDeJogadorCtrl = achaTerritoriosDeJogador

{-
    moverTropaCtrl: Função para deslocar as tropas de um território a outro, desde
                    que cumpra as restrições. A função devolve uma lista contendo
                    os novos territórios após o deslocamento das tropas.
-}

moverTropaCtrl :: Territorio -> Territorio -> Int -> [Territorio]
moverTropaCtrl ter1 ter2 qntd
    | isJust ters = maybeTerList ters
    | otherwise = []
    where ters = moverTropaSrv ter1 ter2 qntd

{-
    batalha: Função responsável por fazer a batalha entre as tropas
             de dois territórios. Após finalizada, retorna uma lista
             com dois elementos que representa quantas tropas foram perdidas
             por cada território.
-}

batalha :: [Int] -> [Int] -> [Int]
batalha d_at d_df
    | m1 > m2 && not (null d_m1)  && not (null d_m2) = zipWith (+) [0,-1] (batalha d_m1 d_m2)
    | m1 <= m2 && not (null d_m1) && not (null d_m2) = zipWith (+) [-1,0] (batalha d_m1 d_m2)
    | m1 > m2 && (null d_m1 || null d_m2) = [0,-1]
    | m1 <= m2 && (null d_m1 || null d_m2) = [-1,0]
    where m1 = maximum d_at
          m2 = maximum d_df
          d_m1 = delete m1 d_at
          d_m2 = delete m2 d_df

{-
    resultadoBatalha: Função responsável por rolar os dados e
                      realizar a batalha entre as tropas através
                      da chamada da função específica para isso.
-}

resultadoBatalha :: Int -> Int -> IO [Int]
resultadoBatalha t_df t_at = do

    num1 <- rollDice :: IO Int
    num2 <- rollDice :: IO Int
    num3 <- rollDice :: IO Int
    num4 <- rollDice :: IO Int
    num5 <- rollDice :: IO Int
    num6 <- rollDice :: IO Int

    let a = [num1,num2,num3]
    let b = [num4,num5,num6]

    if t_at == 3 && t_df == 3 then return (batalha a b)
    else if t_at == 2 && t_df == 3 then return (batalha (tail a) b)
    else if t_at == 3 && t_df == 2 then return (batalha a (tail b))
    else if t_at == 2 && t_df == 2 then return (batalha (tail a) (tail b))
    else if t_at == 2 && t_df == 1 then return (batalha (tail a) [head b])
    else if t_at == 1 && t_df == 2 then return (batalha [head a] (tail b))
    else if t_at == 1 && t_df == 1 then return (batalha [head a] [head b])
    else if t_at == 3 && t_df == 1 then return (batalha a [head b])
    else return (batalha [head a] b)

{-
    adicionaRemoveTropa: Função responsável por regazer o balanceamento das
                         tropas que foram perdidas pelos territórios na batalha.
                         Além disso, troca o domínio do território caso o atacante
                         tenha vencido sob o defensor.
-}

adicionaRemoveTropa :: Int -> [Int] -> Territorio -> Territorio -> [Territorio]
adicionaRemoveTropa player tropasPerdidas territorioAtaque territorioDefesa
    | quantidadeDeTropas territorioDefesa + (tropasPerdidas !! 1) == 0 = [Territorio {nomeTerritorio = nomeTerritorio territorioDefesa, vizinhos = vizinhos territorioDefesa, quantidadeDeTropas = 1, dono = player}, Territorio {nomeTerritorio = nomeTerritorio territorioAtaque, vizinhos = vizinhos territorioAtaque, quantidadeDeTropas = quantidadeDeTropas territorioAtaque + head tropasPerdidas, dono = player}]
    | otherwise = [Territorio {nomeTerritorio = nomeTerritorio territorioDefesa, vizinhos = vizinhos territorioDefesa, quantidadeDeTropas = quantidadeDeTropas territorioDefesa + tropasPerdidas !! 1, dono = dono territorioDefesa}, Territorio {nomeTerritorio = nomeTerritorio territorioAtaque, vizinhos = vizinhos territorioAtaque, quantidadeDeTropas = quantidadeDeTropas territorioAtaque + head tropasPerdidas, dono = player}]

{-
    verficaDomContCtrl: Verifica se um jogador é dono do continente.
-}

verificaDomContCtrl :: Jogo -> Continente -> Jogador -> Int -> Jogador
verificaDomContCtrl jogo cont jg idJogador = if length (verificaDomCont cont (achaTerritoriosDeJogadorCtrl jogo idJogador)) == length (territoriosContinente cont)
    then atualizaContJogador jg 0
    else atualizaContJogador jg (-1)

{-
    verificaDomTodosContCtrl: Auxilia a função anterior para que todos os
                              continentes sejam verificados.
-}

verificaDomTodosContCtrl :: Jogo -> [Continente] -> Jogador -> Int -> Jogador
verificaDomTodosContCtrl jogo [] jogador idjogador = jogador
verificaDomTodosContCtrl jogo (x:xs) jogador idjogador = verificaDomTodosContCtrl jogo xs (verificaDomContCtrl jogo x jogador idjogador) idjogador

{-
    recebeTropaCtrl: Distribui ao jogador suas tropas iniciais (igual 
                     no JogoSrv).
-}

recebeTropaCtrl :: Jogo -> Int -> Int
recebeTropaCtrl jogo player = recebeTropas jogo player

{-
    verificaTerritorioJgrCtrl: Verifica se o jogador é o dono daquele
                               território.
-}

verificaTerritorioJgrCtrl :: Territorio -> Int -> Bool
verificaTerritorioJgrCtrl = verificaTerritorioJgr

{-
    atualizaListaDeTerritorios: Função responsável por atualizar a lista
                                de territórios de um jogo com os novos
                                estados dos territórios.
-}

atualizaListaDeTerritorios :: Jogo -> [Territorio] -> Jogo
atualizaListaDeTerritorios jogo territoriosModificados = Jogo {
    continentes = continentes jogo,
    territorios = auxAtualizaListaDeTerritoriosFor territoriosModificados (territorios jogo),
    jogadores = jogadores jogo
}

{-
    auxAtualizaListaDeTerritoriosFor: Função auxiliar para que passe por todos
                                      os territórios modificados.
-}

auxAtualizaListaDeTerritoriosFor :: [Territorio] -> [Territorio] -> [Territorio]
auxAtualizaListaDeTerritoriosFor [] territoriosOri = territoriosOri
auxAtualizaListaDeTerritoriosFor (a:as) territoriosOri = auxAtualizaListaDeTerritoriosFor as (auxAtualizaListaDeTerritorios a territoriosOri)

{-
    auxAtualizaListaDeTerritorios: Função auxiliar para inserir o novo estado de um
                                   território na lista retirando o estado anterior.
-}

auxAtualizaListaDeTerritorios :: Territorio -> [Territorio] -> [Territorio]
auxAtualizaListaDeTerritorios terr [] = [terr]
auxAtualizaListaDeTerritorios terr (a:as)
    | nomeTerritorio terr == (nomeTerritorio a) = [terr] ++ as
    | otherwise = [a] ++ (auxAtualizaListaDeTerritorios terr as)

{-
    atualizaTerJogadorCtrl: Função que retorna um novo estado do jogador
                            caso tenha ocorrido alterações na sua posse
                            de territórios.
-}

atualizaTerJogadorCtrl :: Jogador -> Jogo -> Int -> Jogador
atualizaTerJogadorCtrl = atualizaTerJogador

pegaVizinhosETropasTerritorios :: Territorio -> IO()
pegaVizinhosETropasTerritorios terr =
    print (nomeTerritorio terr ++ ": Quantidade de Tropas = " ++ show (quantidadeDeTropas terr) ++ ", " ++ "Vizinhos = " ++ unwords (vizinhos terr))


imprimeTerritoriosJogador :: [Territorio] -> IO ()
imprimeTerritoriosJogador [] = return ()
imprimeTerritoriosJogador (a:as) = do pegaVizinhosETropasTerritorios a
                                      imprimeTerritoriosJogador as

converteTer :: [Territorio] -> [String] -> [Territorio]
converteTer ters (x:xs)
    | null xs = maybeToList (getTerritorio ters x)
    | otherwise = maybeToList (getTerritorio ters x) ++ converteTer ters xs
