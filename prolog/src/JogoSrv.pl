:- consult('../structs.pl').

/* Move tropas de um território para outro, contanto que os dois sejam vizinhos e sejam dominados pelo mesmo jogador. */
/*mover_tropa_srv(TerritorioOrigem, TerritorioDestino, NumTropas, NovoTerritorio) :-
    TerritorioOrigem = territorio(NomeTerritorio1, QuantidadeDeTropas1, Vizinhos1, Dono1),
    TerritorioDestino = territorio(NomeTerritorio2, QuantidadeDeTropas2, Vizinhos2, Dono2),

    QuantidadeDeTropas1Atualizado is QuantidadeDeTropas1 - NumTropas,
    (QuantidadeDeTropas1Atualizado =< 0 ;
    not(verifica_vizinhos(NomeTerritorio2, Vizinhos1)) ;
    not(verifica_territorio_jgr(TerritorioDestino, Dono1)) -> NovoTerritorio = none ;
    mover_tropa(TerritorioOrigem, TerritorioDestino, NumTropas, NovoTerritorio)).*/

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

getTerritoriosJogador(Player,ListaTerr):-
    get_global_variable(Player,ListaTerr).

setTerritoriosJogador(Player,ListaTerr):-
    set_global_variable(Player,ListaTerr).

getTerritoriosContinente(Continente,ListaTerr):-
    get_global_variable(Continente,ListaTerr).

setTerritoriosContinente(Continente,ListaTerr):-
    set_global_variable(Continente,ListaTerr).

getVizinhos(ListaVizinhos):-
    get_global_variable(vizinhos,ListaVizinhos).

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

addTerrJogador(Player, Terr):-
    getTerritoriosJogador(Player,ListaTerr),
    append([Terr],ListaTerr,ListaTerrAtualizada),
    setTerritoriosJogador(Player,ListaTerrAtualizada).

main :-
    set_global_variables,
    halt.
:- main.
