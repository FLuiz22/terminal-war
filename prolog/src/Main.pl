:- consult('JogoCtrl.pl').
:- consult('JogoSrv.pl').
:- consult('Arte.pl').
:- encoding(utf8).

game :-
    rodada(jogador1),
    rodada(jogador2),
    verificaVitoriaCtrl(Result),
    (Result = none -> game ; (write("Vencedor: "), write(Result), exibirTelaGameOver, halt)).

rodada(Jogador):-
    write("Rodada "), writeln(Jogador),
    recebeTropas(Jogador, N_TropasRecebidas),
    distribuiTodasTropas(Jogador, N_TropasRecebidas),
    exibirOpcoesRodada,
    read(X),
    (X =:= 1 -> (exibirTelaAtaque, loopAtaque(Jogador)); 
    (X =:= 2 -> (exibirTelaMoverTropas, loopMovimento(Jogador)); 
    writeln("Fim da rodada."))).


distribuiTodasTropas(Jogador, N_tropas) :-
    write("Você tem: "), write(N_tropas), writeln(" tropa(s) para distribuir."),
    writeln("Qual território receberá as X tropas?"),
    read(TerrAlvo),
    (\+ verificaTerrJgdr(Jogador, TerrAlvo) -> (writeln("Território não pertence ao jogador."), distribuiTodasTropas(Jogador, N_tropas)) ;
    write("Quantas tropas serão distribuidas para o território?"),
    read(N_tropasAlvo),
    (N_tropasAlvo > N_tropas -> (writeln("Tropas disponíveis insuficientes."), distribuiTodasTropas(Jogador, N_tropas)) ;
    adicionaTropa(N_tropasAlvo, TerrAlvo),
    N_TropasRestantes is N_tropas - N_tropasAlvo,
    N_TropasRestantes =\= 0 -> distribuiTodasTropas(Jogador, N_TropasRestantes); writeln(""))).

loopAtaque(Jogador) :-
    writeln("Insira o território de onde partirá o ataque:"),
    read(TerrOrigem),
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
    exibirTelaLoopAtaque,
    read(Continue),
    (Continue =:= 1 -> loopAtaque(Jogador); writeln("Fim da rodada")))).
    
loopMovimento(Jogador) :-

    exibirTelaMoverTropas,
    
    writeln("Insira o território de onde suas tropas sairão:  "),
    read(TerritorioOrigem),
    (\+ verificaTerrJgdr(Jogador, TerritorioOrigem) -> (writeln("Território não pertence ao jogador."), loopMovimento(Jogador)) ;
    writeln("Insira quantas tropas serão movidas: "),
    read(QuantidadeTropas),
    (\+ verificaTropasTerritorio(TerritorioOrigem, QuantidadeTropas) -> (writeln("Tropas insuficientes no território"), loopMovimento(Jogador)) ;
    writeln("Insira o território: "),
    read(TerritorioDestino),
    (\+ verificaTerrJgdr(Jogador, TerritorioDestino) -> (writeln("Território não pertence ao jogador."), loopMovimento(Jogador)) ;
    (\+ verificaVizinhos(TerritorioOrigem, TerritorioDestino) -> (writeln("Território de destino não é vizinho ao território de origem."), loopMovimento(Jogador)) ;
    moverTropaCtrl(TerritorioOrigem, TerritorioDestino, QuantidadeTropas),   

    exibirTelaLoopMoverTropas,
    read(Continue),
    (Continue =:= 1 -> loopMovimento(Jogador); writeln("Fim da rodada")))))).
