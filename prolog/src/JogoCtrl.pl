:- consult('JogoSrv.pl').

verificaVitoriaCtrl(Result) :-
    get_global_variable(jogador1, J1),    
    get_global_variable(jogador2, J2),
    verificaVitoriaSrv(J1,J2,Result).

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
