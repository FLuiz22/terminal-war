:- consult('JogoCtrl.pl').
:- consult('JogoSrv.pl').
:- consult('Arte.pl').
:- encoding(utf8).


/*
            game: Realiza a função do jogo, verificando se já houve algum vencedor, caso não,
                                a função é chamada recursivamente, se sim, o jogo se encerra.


*/
game :-
    rodada(jogador1),
    verificaVitoriaCtrl(Result1),
    (Result1 = none -> true ; (write("Vencedor: "), writeln(Result1), exibirTelaGameOver, halt)),
    writeln("Fim da rodada."), 
    writeln("-------------------------------------------------------------"),
    rodada(jogador2),
    verificaVitoriaCtrl(Result2),
    (Result2 = none -> (writeln("Fim da rodada."), 
    writeln("-------------------------------------------------------------"), game) ; 
    (write("Vencedor: "), writeln(Result2), exibirTelaGameOver, halt)).


/*
        ataque: Função que realiza o ataque de um jogador de acordo
            com sua escolha de alvo, após a batalha, ambos os
            territórios podem acabar modificados, então eles
            possuem sua quantidade de tropas alteradas e
            um novo estado do jogo é criado com as mudanças
            realizadas e é retornado pela função para que o
            jogador batalhe novamente ou só passe sua vez.

*/


rodada(Jogador):-
    write("Rodada "), writeln(Jogador),
    recebeTropas(Jogador, N_TropasRecebidas),
    distribuiTodasTropas(Jogador, N_TropasRecebidas),
    exibirOpcoesRodada,
    read(X),
    (X =:= 1 -> (loopAtaque(Jogador)); 
    (X =:= 2 -> (loopMovimento(Jogador)); true)).


/*      distribuiTodasTropas: Função responsável pela distribuição das tropas
                          recebidas no início de cada rodada, sendo obrigatória
                          a distribuição de todas elas entre os territórios
                          possuídos pelo jogador. Após a distribuição, retorna
                          uma lista com todos os territórios que foram alterados
                          para que outra função possa receber essa lista e
                          criar um novo estado do jogo após a ação do jogador.
*/


distribuiTodasTropas(Jogador, N_tropas) :-
    imprimeGeral(Jogador),
    write("Você tem: "), write(N_tropas), writeln(" tropa(s) para distribuir."),
    writeln("Qual território receberá as X tropas?"),
    read(TerrAlvo),
    (\+ verificaTerrJgdr(Jogador, TerrAlvo) -> (writeln("Território não pertence ao jogador."), distribuiTodasTropas(Jogador, N_tropas)) ;
    writeln("Quantas tropas serão distribuidas para o território?"),
    read(N_tropasAlvo),
    (N_tropasAlvo > N_tropas -> (writeln("Tropas disponíveis insuficientes."), distribuiTodasTropas(Jogador, N_tropas)) ;
    adicionaTropa(N_tropasAlvo, TerrAlvo),
    N_TropasRestantes is N_tropas - N_tropasAlvo,
    N_TropasRestantes =\= 0 -> distribuiTodasTropas(Jogador, N_TropasRestantes); true)).


/*      loopAtaque: Função responsável pelo looping da ação de atacar.
                Quando escolhida pelo jogador, possibilita ele escolher quantas
                tropas irão atacar e qual território será atacado, desde que este seja vizinho
                de algum território em sua posse, além disso, pode
                atacar quantas vezes quiser. Ao fim dos ataques, a função
                retorna o novo estado do jogo após esses ataques.
*/


loopAtaque(Jogador) :-

    exibirTelaAtaque,

    imprimeGeral(Jogador),

    writeln("Insira o território de onde partirá o ataque:"),
    read(TerrOrigem),
    getTerritoriosJogador(Jogador, TerritoriosJogador),
    (\+ member(TerrOrigem, TerritoriosJogador) -> writeln("Territorio não pertence ao jogador."), loopAtaque(Jogador); 
    writeln("Insira o território que será atacado:"), 
    read(TerrAlvo),
    (member(TerrAlvo, TerritoriosJogador) -> writeln("Território já pertence ao jogador"), loopAtaque(Jogador);
    writeln("Insira quantas tropas irão atacar o território inimigo:"),
    read(N_tropasAt),
    (\+ verificaTropasTerritorio(TerrOrigem, N_tropasAt) -> (writeln("Pelo menos uma tropa deve permanecer no território (tropa de ocupação)."), loopAtaque(Jogador)) ;
    (Jogador = jogador1 -> (ataque(jogador1, jogador2, N_tropasAt, TerrOrigem, TerrAlvo, TropasPerdidasAt, TropasPerdidasDf)); (ataque(jogador2, jogador1, N_tropasAt, TerrOrigem, TerrAlvo, TropasPerdidasAt, TropasPerdidasDf))),
    write("O território "), write(TerrOrigem), write(" perdeu "), write(TropasPerdidasAt), writeln(" tropa(s)"),
    write("O território "), write(TerrAlvo), write(" perdeu "), write(TropasPerdidasDf), writeln(" tropa(s)"),
    
    exibirTelaLoopAtaque,
    read(Continue),
    (Continue =:= 1 -> loopAtaque(Jogador); true)))).


/*      loopMovimento: Função responsável pelo loop da ação de mover
                   tropas do jogador, possibilitando ele mover
                   as suas tropas entre seus territórios,
                   desde que estes sejam vizinhos, e quantas
                   vezes quiser. Após a ação do jogador, retorna
                   o novo estado do jogo com os deslocamentos que
                   ele realizou.
*/


loopMovimento(Jogador) :-

    exibirTelaMoverTropas,
    imprimeGeral(Jogador),
    
    writeln("Insira o território de onde suas tropas sairão:  "),
    read(TerritorioOrigem),
    (\+ verificaTerrJgdr(Jogador, TerritorioOrigem) -> (writeln("Território não pertence ao jogador."), loopMovimento(Jogador)) ;
    writeln("Insira quantas tropas serão movidas: "),
    read(QuantidadeTropas),
    (\+ verificaTropasTerritorio(TerritorioOrigem, QuantidadeTropas) -> (writeln("Tropas insuficientes no território"), loopMovimento(Jogador)) ;
    writeln("Insira o território que receberá as tropas: "),
    read(TerritorioDestino),
    (\+ verificaTerrJgdr(Jogador, TerritorioDestino) -> (writeln("Território não pertence ao jogador."), loopMovimento(Jogador)) ;
    (\+ verificaVizinhos(TerritorioOrigem, TerritorioDestino) -> (writeln("Território de destino não é vizinho ao território de origem."), loopMovimento(Jogador)) ;
    moverTropaCtrl(TerritorioOrigem, TerritorioDestino, QuantidadeTropas),   

    exibirTelaLoopMoverTropas,
    read(Continue),
    (Continue =:= 1 -> loopMovimento(Jogador); true))))).

:- exibirInicio, game.