:- consult('./TerritorioSrv.pl').

/* Verifica caso um jogador já tenha vencido baseado nas condiçoes, um jogador esteja com 0 territórios,
    ou um já tenha conquistado 2 continentes */

verificaVitoriaSrv(Jogador1, Jogador2, Result) :-

    calculaQuantidadeTerritoriosJogador(Jogador1, QuantidadeTerritorios1),
    calculaQuantidadeTerritoriosJogador(Jogador2,QuantidadeTerritorios2),

    calculaQuantidadeContinentesJogador(Jogador1,QuantidadeContinentes1),
    calculaQuantidadeContinentesJogador(Jogador2, QuantidadeContinentes2),

    (   (QuantidadeTerritorios1 =:= 0, QuantidadeTerritorios2 > 0)-> Result = 'Jogador 2';
        (QuantidadeTerritorios2 =:= 0, QuantidadeTerritorios1 > 0)-> Result = 'Jogador 1';
        (QuantidadeContinentes1 >= 2, QuantidadeContinentes2 < 2)-> Result = "Jogador1";
        (QuantidadeContinentes2 >= 2, QuantidadeContinentes1 < 0)-> Result= "Jogador2";
        Result = none
    ).

calculaQuantidadeTerritoriosJogador(Jogador,R):-
    getTerritoriosJogador(Jogador,Terrs),
    length(Terrs,R).

calculaQuantidadeContinentesJogador(Jogador,R) :-
    auxCalculaQuantidadeContinentesJogador(Jogador,0,R).

auxCalculaQuantidadeContinentesJogador(Jogador, Quant, R) :-
    (verificaDomContinente(Jogador, america) -> Quant1 is Quant + 1; Quant1 is Quant),
    (verificaDomContinente(Jogador, africa) -> Quant2 is Quant1 + 1; Quant2 is Quant1),
    (verificaDomContinente(Jogador, asia) -> Quant3 is Quant2 + 1; Quant3 is Quant2),
    (verificaDomContinente(Jogador, europa) -> Quant4 is Quant3 + 1; Quant4 is Quant3),
    (verificaDomContinente(Jogador, oceania) -> R is Quant4 + 1; R is Quant4).

/* Move tropas de um território para outro, contanto que os dois sejam vizinhos e sejam dominados pelo mesmo jogador. */
mover_tropa_srv(Territorios, TerritorioOrigem, TerritorioDestino, NumTropas, TerritorioAt) :-
    mover_tropa(Territorios, TerritorioOrigem, TerritorioDestino, NumTropas, TerritorioAt).

somaLista([H1,T1], [H2,T2], [S,R]) :- 
    S is H1 + H2,
    R is T1 + T2.

sameList([], []).
sameList([H1|R1], [H2|R2]):-
    H1 = H2,
    sameList(R1, R2).

removeItem(Y, [Y], []).
removeItem(X, [X|Y], Y).
removeItem(X, [Y|List], [Y|List1]):- removeItem(X,List,List1).

rollDices(N,R):-
    N =:= 3 -> (random(1,7,R1),random(1,7,R2),random(1,7,R3),R=[R1,R2,R3]);
    (N > 1 -> (random(1,7,R1),random(1,7,R2), R=[R1,R2]); (random(1,7,R1), R = [R1])).

batalhas(Dados1,Dados2,R) :-
    sort(0,@>=,Dados1,A),
    sort(0,@>=,Dados2,B),
    reverse(A,Dados_At),
    reverse(B,Dados_Df),
    batalha(Dados_At,Dados_Df,R1),
    R = R1.

batalha(_,[],[0,0]).
batalha([],_,[0,0]).
batalha(Dados_At,Dados_Df,R):-
    nth0(0,Dados_At,Ataque1), nth0(0,Dados_Df,Defesa1),
    removeItem(Ataque1,Dados_At,At2), removeItem(Defesa1,Dados_Df,Df2),
    batalha(At2,Df2,R1),
    (Ataque1 > Defesa1 -> (somaLista([0,-1], R1, R2));(somaLista([-1,0], R1, R2))),
    R = R2.

calculaTropas(N_terr,N_recebe):-
    (N_terr > 1 -> N_recebe is N_terr // 2; N_recebe is 1).

recebeTropas(Player,N_tropas):-
    getTerritoriosJogador(Player,ListaTerr),
    length(ListaTerr,N_terr),
    calculaTropas(N_terr,TropasRecebidas),
    N_tropas = TropasRecebidas.
   
verificaTerrJgdr(Player, Terr):-
    getTerritoriosJogador(Player, ListaTerr),
    member(Terr,ListaTerr).

verificaVizinhos(Terr1,Terr2):-
    getVizinhos(ListaVizinhos),
    get_dict(Terr1,ListaVizinhos,Vizinhos),
    member(Terr2,Vizinhos).

verificaDomContinente(Player, Continente):-
    getTerritoriosJogador(Player,ListaTerrPlayer),
    getTerritoriosContinente(Continente, ListaTerrCont),
    sort(0,@=<,ListaTerrPlayer,ListaTerrPlaterSort),
    sort(0,@=<,ListaTerrCont,ListaTerrContSort),
    subset(ListaTerrContSort, ListaTerrPlaterSort).