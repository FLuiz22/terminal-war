:- consult('JogoCtrl.pl').
:- consult('JogoSrv.pl').
:- consult('Arte.pl').
:- encoding(utf8).

game :-
    rodada(jogador1),
    rodada(jogador2),
    verificaVitoriaCtrl(Result),
    (Result = none -> game ; (write("Vencedor: "), write(Result), halt)).

DistribuiTodasTropas(Jogador, N_tropas) :-
    write("Você tem: "), write(N_tropas), writeln(" tropa(s) para distribuir."),
    writeln("Qual território receberá as X tropas?"),
    read(TerrAlvo),
    write("Quantas tropas serão distribuidas para o território?"),
    read(N_tropasAlvo),
    /*oi insira algo aqui */
    N_TropasRestantes is N_tropas - N_tropasAlvo,
    N_TropasRestantes =\= 0 -> DistribuiTodasTropas(Jogador, N_TropasRestantes).

loopAtaque(Jogador) :-
    writeln("Insira o território de onde partirá o ataque:"),
    read(TerrOrigem),
    writeln("Insira o território que será atacado:"),
    read(TerrAlvo),
    writeln("Insira quantas tropas irão atacar o território inimigo:"),
    read(N_tropasAt),
    (Jogador = jogador1 -> (ataque(jogador1, jogador2, N_tropasAt, TerrOrigem, TerrAlvo, TropasPerdidasAt, TropasPerdidasDf)); (ataque(jogador2, jogador1, N_tropasAt, TerrOrigem, TerrAlvo, TropasPerdidasAt, TropasPerdidasDf))),
    write("O território "), write(TerrOrigem), write(" perdeu "), write(TropasPerdidasAt), writeln(" tropa(s)"),
    write("O território "), write(TerrAlvo), write(" perdeu "), write(TropasPerdidasDf), writeln(" tropa(s)"),
    /* Tela de loop ataque */
    writeln("Continuar?"),
    read(Continue),
    (Continue =:= 1 -> loopAtaque(Jogador); write("Fim da rodada")).
    
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
