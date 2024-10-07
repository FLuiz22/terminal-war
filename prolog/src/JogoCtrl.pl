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

addTerrJogador(Player, Terr):-
    getTerritoriosJogador(Player,ListaTerr),
    append([Terr],ListaTerr,ListaTerrAtualizada),
    setTerritoriosJogador(Player,ListaTerrAtualizada).

removeTerritorioJgdr(Jogador, Territorio):-
    getTerritoriosJogador(Jogador, Territorios),
    removeItem(Territorio, Territorios, TerritoriosAtualizado),
    setTerritoriosJogador(Jogador, TerritoriosAtualizado).

/* mover_tropa_ctrl: Função para deslocar as tropas de um território a outro, desde
                      que cumpra as restrições. A função devolve uma lista contendo
                      os novos territórios após o deslocamento das tropas. */


mover_tropa_ctrl(TerritorioOrigem, TerritorioDestino, NumTropas) :-
    get_global_variable(territorios, Territorios),
    get_dict(TerritorioOrigem, Territorios, V1),
    V1 - NumTropas >= 1,
    mover_tropa_srv(Territorios, TerritorioOrigem, TerritorioDestino, NumTropas, Resultado),
    set_global_variable(territorios, Resultado).

ataque(JogadorAtaque, JogadorDefesa, N_TropasAt, TerrOrigem, TerrAlvo, TropasPerdidasAt, TropasPerdidasDf) :-
    get_global_variable(territorios, Territorios),
    get_dict(TerrAlvo, Territorios, QntdAtual),
    (QntdAtual > 3 -> N_TropasDf = 3; N_TropasDf = QntdAtual),
    rollDices(N_TropasAt,D1),
    rollDices(N_TropasDf,D2),
    batalhas(D1,D2,R),
    nth0(0,R,T1),
    abs(T1,TropasPerdidasAt),
    nth0(1,R,T2),
    abs(T2,TropasPerdidasDf),
    (QntdAtual - TropasPerdidasDf =:= 0 ->
    perdeTerritorio(JogadorAtaque, JogadorDefesa, TropasPerdidasAt, TropasPerdidasDf, TerrOrigem, TerrAlvo);
    remove_tropa(Territorios, TerrOrigem, TropasPerdidasAt, N1),
    remove_tropa(N1, TerrAlvo, TropasPerdidasDf, N2),
    set_global_variable(territorios, N2)).

perdeTerritorio(JogadorGanhou,JogadorPerdeu,TropasPerdidasAt,TropasPerdidasDf,TerritorioOrigem, TerritorioAlvo):-
    get_global_variable(territorios, Territorios),
    TPDF is TropasPerdidasDf-1, 
    TPAT is TropasPerdidasAt+1,
    remove_tropa(Territorios, TerritorioAlvo, TPDF, TerritorioAlvoAtualizado), 
    removeTerritorioJgdr(JogadorPerdeu,TerritorioAlvo), 
    remove_tropa(TerritorioAlvoAtualizado, TerritorioOrigem, TPAT, TerritorioOrigemAtualizado), 
    addTerrJogador(JogadorGanhou,TerritorioAlvo),
    set_global_variable(territorios, TerritorioOrigemAtualizado).
    

    
imprimeTerritoriosJogador(Player) :-
    getTerritoriosJogador(Player, ListaTerr),
    imprimeTerritorios(ListaTerr).

imprimeTerritorios([]) :- !. 
imprimeTerritorios([Territorio|TerrRestantes]) :-
    pegaVizinhosETropasTerritorios(Territorio), 
    imprimeTerritorios(TerrRestantes).  

pegaVizinhosETropasTerritorios(Territorio) :-
    get_global_variable(territorios, Territorios),
    get_dict(Territorio, Territorios, NumTropas),
    format('Território: ~w, Tropas: ~w~n', [Territorio, NumTropas]),
    getVizinhos(ListaVizinhos),
    format('Vizinhos: ~w~n', [ListaVizinhos]).    
