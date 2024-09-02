module Main where

import Territorio
import JogoCtrl
import JogoSrv
import Util
import Jogo
import Jogador
import Data.Maybe
import Arte
import System.Exit (exitSuccess)

main :: IO ()
main = do
    initGame

{-
    initGame: Função responsável por começar o jogo com os estados iniciais e
              chamando as demais funções necessárias para que os jogadores realizem as
              ações desejadas. 

    Obs: Possui a verificação de vitória (explicação no continueLoop).
-}

initGame :: IO()
initGame = do
    let jogo = startGameCtrl
    let jogador1 = fst (jogadores jogo)
    let jogador2 = snd (jogadores jogo)

    exibirInicio
    terjg1 <- rodada jogo 1 jogador1
    
    let jogo15 = atualizaListaDeTerritorios jogo terjg1
    
    let jogador11 = atualizaTerJogadorCtrl jogador1 jogo15 1
    let jogador21 = atualizaTerJogadorCtrl jogador2 jogo15 2

    jogo02 <- rodada jogo15 2 jogador2

    let jogo2 = atualizaListaDeTerritorios jogo15 jogo02

    let jogador12 = atualizaTerJogadorCtrl jogador1 jogo2 1
    let jogador22 = atualizaTerJogadorCtrl jogador2 jogo2 2

    let mVit = verificaVitoriaCtrl jogador12 jogador22

    if not (null mVit)
        then do
            exibirTelaGameOver
            print ("Vitoria do " ++ mVit)
            exitSuccess
    else continueLoop jogo2 jogador12 jogador22

{-
    continueLoop: Função que possui a responsabilidade de continuar o loop do jogo, 
                  similarmente a primeira chamada da função 'initGame', mas com
                  a diferença que esta recebe o estado do jogo atualizado 
                  possibilitando a progressão do tabuleiro. Além disso, a cada vez,
                  realiza a verificação de vitória para um jogador que, caso cumprida,
                  informa quem foi o vencedor e encerra o jogo.
-}

continueLoop :: Jogo -> Jogador -> Jogador -> IO()
continueLoop jogo jogador1 jogador2 = do

    terjg1 <- rodada jogo 1 jogador1
    
    let jogo1 = atualizaListaDeTerritorios jogo terjg1

    let jogador1' = atualizaTerJogadorCtrl jogador1 jogo1 1
    let jogador2' = atualizaTerJogadorCtrl jogador2 jogo1 2

    jogo02 <- rodada jogo1 2 jogador2

    let jogo2 = atualizaListaDeTerritorios jogo1 jogo02

    let jogador11 = atualizaTerJogadorCtrl jogador1' jogo2 1
    let jogador21 = atualizaTerJogadorCtrl jogador2' jogo2 2

    let copiaJogador1 = Jogador {quantidadeTerritorios = quantidadeTerritorios jogador11, quantidadeContinentes = 5}
    let copiaJogador2 = Jogador {quantidadeTerritorios = quantidadeTerritorios jogador21, quantidadeContinentes = 5}

    let jogador1Atualizado = verificaDomTodosContCtrl jogo2 (continentes jogo2) copiaJogador1 1
    -- print (show (quantidadeContinentes jogador1Atualizado))
    let jogador2Atualizado = verificaDomTodosContCtrl jogo2 (continentes jogo2) copiaJogador2 2
    -- print (show (quantidadeContinentes jogador2Atualizado))

    let mVit = verificaVitoriaCtrl jogador1Atualizado jogador2Atualizado

    if not (null mVit)
        then do
            exibirTelaGameOver
            print ("Vitoria do " ++ mVit)
            exitSuccess
    else
        continueLoop jogo2 jogador1Atualizado jogador2Atualizado

{-
    rodada: Função responsável pelo gerenciamento das possíveis ações
            de um jogador na rodada, podendo atacar, mover suas tropas
            ou simplesmente passar a vez, tendo essas opções apenas após
            distribuir as tropas recebidas no começo da rodada em qualquer
            um dos território que possui. Após a rodada do jogador ser
            encerrada, a função retorna um novo estado do jogo criado
            a partir das ações que foram realizadas pelo jogador.
-}

rodada :: Jogo -> Int -> Jogador -> IO [Territorio]
rodada jogo player jogador = do
    let tropas_recebidas = recebeTropaCtrl jogo player
    let mensagem = "Você recebeu" ++ " " ++ show tropas_recebidas ++ " " ++ "tropa(s)"
    putStrLn mensagem
    terr_modificados <- distribuiTodasTropas jogo player tropas_recebidas
    let jogo1 = atualizaListaDeTerritorios jogo terr_modificados
    exibirOpcoesRodada
    prox <- readLn
    if prox == 1
        then do
            exibirTelaAtaque
            loopAtaque jogo1 player
    else if prox == 2
        then do
            exibirTelaMoverTropas
            loopMovimento jogo1 player
    else return terr_modificados


{-
    distribuiTodasTropas: Função responsável pela distribuição das tropas
                          recebidas no início de cada rodada, sendo obrigatória
                          a distribuição de todas elas entre os territórios
                          possuídos pelo jogador. Após a distribuição, retorna
                          uma lista com todos os territórios que foram alterados
                          para que outra função possa receber essa lista e
                          criar um novo estado do jogo após a ação do jogador.
-}

distribuiTodasTropas :: Jogo -> Int -> Int -> IO [Territorio]
distribuiTodasTropas jogo player n_tropas = do
    imprimeTerritoriosJogador (converteTer (territorios jogo) (achaTerritoriosDeJogadorCtrl jogo player))
    if n_tropas > 1 then do
        putStrLn "Qual o território que receberá as x tropas?"
        territorioAlvo <- getLine
        let territorio = head (maybeToList (getTerritorio (territorios jogo) territorioAlvo))
        if verificaTerritorioJgrCtrl territorio player then do
            putStrLn "Quantas tropas serão distribuidas para esse território?"
            numTropasParaDistribuir <- readLn

            if numTropasParaDistribuir <= n_tropas && n_tropas - numTropasParaDistribuir >= 1 then do
                ts <- distribuiTodasTropas jogo player (n_tropas - numTropasParaDistribuir)
                return (head (maybeToList (distribuiTropas player numTropasParaDistribuir territorio)) : ts)
            else return (maybeToList (distribuiTropas player numTropasParaDistribuir territorio))
        else do
            putStrLn "Territorio Inválido, tente novamente"
            distribuiTodasTropas jogo player n_tropas
    else if n_tropas == 1 then do
        putStrLn "Qual o território que receberá as x tropas?"
        territorioAlvo <- getLine
        let territorio = head (maybeToList (getTerritorio (territorios jogo) territorioAlvo))
        if verificaTerritorioJgrCtrl territorio player then
            return (maybeToList (distribuiTropas player n_tropas territorio))
        else do
            putStrLn "Territorio Inválido, tente novamente"
            distribuiTodasTropas jogo player n_tropas
    else
        return []

{-
    loopAtaque: Função responsável pelo looping da ação de atacar.
                Quando escolhida pelo jogador, possibilita ele escolher quantas
                tropas irão atacar e qual território será atacado, desde que este seja vizinho
                de algum território em sua posse, além disso, pode
                atacar quantas vezes quiser. Ao fim dos ataques, a função
                retorna o novo estado do jogo após esses ataques.
-}

loopAtaque :: Jogo -> Int -> IO [Territorio]
loopAtaque jogo player = do
    imprimeTerritoriosJogador (converteTer (territorios jogo) (achaTerritoriosDeJogadorCtrl jogo player))
    putStrLn "Insira o território de onde partirá o ataque:"
    territorioAtaqueInput <- getLine
    putStrLn "Insira o território que você deseja atacar:"
    territorioDefesaInput <- getLine
    putStrLn "Insira quantas tropas irão atacar o território inimigo:"
    t_at <- readLn
    let territorioAtaque = head (maybeToList (getTerritorio (territorios jogo) territorioAtaqueInput))
    let territorioDefesa = head (maybeToList (getTerritorio (territorios jogo) territorioDefesaInput))
    retornoAtaque <- ataque jogo player t_at territorioAtaque territorioDefesa
    let territoriosAtualizados = auxAtualizaListaDeTerritoriosFor retornoAtaque (territorios jogo)
    let jogoN = atualizaListaDeTerritorios jogo retornoAtaque
    
    {-exibir a tela de loopAtaque-}
    exibirTelaLoopAtaque

    continuar <- readLn
    if continuar == 1
        then loopAtaque jogoN player
    else return territoriosAtualizados

{-
    ataque: Função que realiza o ataque de um jogador de acordo
            com sua escolha de alvo, após a batalha, ambos os
            territórios podem acabar modificados, então eles
            possuem sua quantidade de tropas alteradas e
            um novo estado do jogo é criado com as mudanças
            realizadas e é retornado pela função para que o
            jogador batalhe novamente ou só passe sua vez.
-}

ataque :: Jogo -> Int -> Int -> Territorio -> Territorio -> IO [Territorio]
ataque jogo player t_at territorioAtaque territorioDefesa = do

    let t_df =  quantidadeDeTropas territorioDefesa
    if t_df > 3 then do
        tropasPerdidas <- resultadoBatalha 3 t_at
        putStrLn ("O territorio " ++ nomeTerritorio territorioAtaque ++ "perdeu" ++ show (tropasPerdidas !! 0) ++ "tropas" )
        putStrLn ("O territorio " ++ nomeTerritorio territorioDefesa ++ "perdeu" ++ show (tropasPerdidas !! 1) ++ "tropas") 
        return (adicionaRemoveTropa player tropasPerdidas territorioAtaque territorioDefesa)
    else do
        tropasPerdidas <- resultadoBatalha t_df t_at
        return (adicionaRemoveTropa player tropasPerdidas territorioAtaque territorioDefesa)

{-
    loopMovimento: Função responsável pelo loop da ação de mover
                   tropas do jogador, possibilitando ele mover
                   as suas tropas entre seus territórios,
                   desde que estes sejam vizinhos, e quantas
                   vezes quiser. Após a ação do jogador, retorna
                   o novo estado do jogo com os deslocamentos que
                   ele realizou.
-}

loopMovimento :: Jogo -> Int -> IO [Territorio]
loopMovimento jogo player = do
    imprimeTerritoriosJogador (converteTer (territorios jogo) (achaTerritoriosDeJogadorCtrl jogo player))
    putStrLn "Insira o território de onde suas tropas sairão"
    territorioOriginalTropasInput <- getLine
    let territorioOrigem = head (maybeToList (getTerritorio (territorios jogo) territorioOriginalTropasInput))
    putStrLn "Insira quantas tropas serão movidas"
    quantTropas0 <- getLine
    let quantTropas = read quantTropas0 :: Int
    putStrLn "Insira o território destino"
    territorioDestinoTropas <- getLine
    let territorioDestino = head (maybeToList (getTerritorio (territorios jogo) territorioDestinoTropas))
    let retornoMovimento = movimento jogo territorioOrigem territorioDestino quantTropas
    let territoriosAtualizados = auxAtualizaListaDeTerritoriosFor retornoMovimento (territorios jogo)
    let jogoN = atualizaListaDeTerritorios jogo retornoMovimento

    {-Exibir a tela de loopMoverTropas-}
    exibirTelaLoopMoverTropas

    continuar <- readLn
    if continuar == 1
        then
            loopMovimento jogoN player
    else return territoriosAtualizados

{-
    movimento: Função responsável pelo deslocamento das tropas
               de um jogador de um território para outro, desde
               que esteja em sua posse, e, após o deslocamento,
               retorna o novo estado do jogo de acordo com as
               ações feitas pelo jogador.
-}

movimento :: Jogo -> Territorio -> Territorio -> Int -> [Territorio]
movimento jogo terrOri terrDest quantTropas = moverTropaCtrl terrOri terrDest quantTropas
