:- consult('JogoCtrl.pl').
:- consult('JogoSrv.pl').
:- consult('Arte.pl').
:- encoding(utf8).

game :-
    rodada(jogador1),
    rodada(jogador2),
    verificaVitoriaCtrl(Result),
    (Result = none -> game ; (write("Vencedor: "), write(Result), halt)).

rodada(Jogador):-
    write("Rodada "), writeln(Jogador),
    recebeTropas(Jogador, N_TropasRecebidas),
    distribuiTodasTropas(Jogador, N_TropasRecebidas),
    writeln("1. Atacar"),
    writeln("2. Mover tropas"),
    writeln("3. Terminar rodada"),
    read(X),
    (X =:= 1 -> loopAtaque(Jogador); (X =:= 2 -> loopMovimento(Jogador); writeln("Fim da rodada."))).


distribuiTodasTropas(Jogador, N_tropas) :-
    write("Você tem: "), write(N_tropas), writeln(" tropa(s) para distribuir."),
    writeln("Qual território receberá as X tropas?"),
    read(TerrAlvo),
    write("Quantas tropas serão distribuidas para o território?"),
    read(N_tropasAlvo),
    /*oi insira algo aqui */
    N_TropasRestantes is N_tropas - N_tropasAlvo,
    N_TropasRestantes =\= 0 -> distribuiTodasTropas(Jogador, N_TropasRestantes); writeln("Escolha uma opção: ").

loopAtaque(Jogador) :-
    writeln("Insira o território de onde partirá o ataque:"),
    read(TerrOrigem),
    /*Jogador = jogador 1 -> getTerritoriosJogador(jogador2, TerritoriosOponente); getTerritoriosJogador(jogador1, TerritoriosOponente),*/
    getTerritoriosJogador(Jogador, TerritoriosJogador),
    (\+ member(TerrOrigem, TerritoriosJogador) -> writeln("Territorio não pertence ao jogador."), loopAtaque(Jogador); 
    writeln("Insira o território que será atacado:"), 
    read(TerrAlvo),
    (member(TerrAlvo, TerritoriosJogador) -> writeln("Território já pertence ao jogador"), loopAtaque(Jogador);
    writeln("Insira quantas tropas irão atacar o território inimigo:"),
    read(N_tropasAt),
    (Jogador = jogador1 -> (ataque(jogador1, jogador2, N_tropasAt, TerrOrigem, TerrAlvo, TropasPerdidasAt, TropasPerdidasDf)); (ataque(jogador2, jogador1, N_tropasAt, TerrOrigem, TerrAlvo, TropasPerdidasAt, TropasPerdidasDf))),
    write("O território "), write(TerrOrigem), write(" perdeu "), write(TropasPerdidasAt), writeln(" tropa(s)"),
    write("O território "), write(TerrAlvo), write(" perdeu "), write(TropasPerdidasDf), writeln(" tropa(s)"),
    /* Tela de loop ataque */
    writeln("Continuar?"),
    writeln("1. Sim"), writeln("2. Não"),
    read(Continue),
    (Continue =:= 1 -> loopAtaque(Jogador); writeln("Fim da rodada")))).
    
loopMovimento(Jogador) :-

    exibirTelaMoverTropas,
    
    writeln("Insira o território de onde suas tropas sairão:  "),
    read(TerritorioOrigem),
    writeln("Insira quantas tropas serão movidas: "),
    read(QuantidadeTropas),
    writeln("Insira o território: "),
    read(TerritorioDestinoTropas),
    moverTropaCtrl(TerritorioOrigem, TerritorioDestinoTropas, QuantidadeTropas),   

    /*Falta fazer a verificacao se o territorio destino é vizinho do territorio origem*/
    exibirTelaLoopMoverTropas,
    read(Continue),
    (Continue =:= 1 -> loopMovimento(Jogador); writeln("Fim da rodada")).
