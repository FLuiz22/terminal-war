:- consult(['../structs.pl', './JogoSrv.pl']).

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

/* mover_tropa_ctrl: Função para deslocar as tropas de um território a outro, desde
                      que cumpra as restrições. A função devolve uma lista contendo
                      os novos territórios após o deslocamento das tropas. */


mover_tropa_ctrl(TerritorioOrigem, TerritorioDestino, NumTropas, Ter) :-
    get_global_variable(territorios, Territorios),
    get_dict(TerritorioOrigem, Territorios, V1),
    V1 - NumTropas >= 1,
    mover_tropa_srv(Territorios, TerritorioOrigem, TerritorioDestino, NumTropas, Resultado),
    set_global_variable(territorios, Resultado).
