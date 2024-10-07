:- consult(['./structs.pl', './JogoSrv.pl']).

/*      verificaVitoriaCtrl: Verifica caso um jogador já tenha vencido, se sim, 
                        o jogador será retornado, se nao, será retornado None. */


verificaVitoriaCtrl(Result) :-
    getTerritoriosJogador(jogador1, J1),    
    getTerritoriosJogador(jogador2, J2),
    get_global_variable(america, America),
    get_global_variable(europa, Europa),
    get_global_variable(asia, Asia),
    get_global_variable(africa, Africa),
    get_global_variable(oceania, Oceania),
    verificaVitoriaSrv(J1,J2,Result, America, Europa, Asia, Africa, Oceania).


/*      getTerritoriosJogador: Retorna a lista de territórios.  */


getTerritoriosJogador(Player,ListaTerr):-
    get_global_variable(Player,ListaTerr).


/*      setTerritoriosJogador: Define a lista de territórios de um jogador. */


setTerritoriosJogador(Player,ListaTerr):-
    set_global_variable(Player,ListaTerr).


/*      getTerritoriosContinente: Retorna a lista de territórios de um continente. */


getTerritoriosContinente(Continente,ListaTerr):-
    get_global_variable(Continente,ListaTerr).


/*      setTerritoriosContinente: Defina a lista de territórios de um continente*/
setTerritoriosContinente(Continente,ListaTerr):-
    set_global_variable(Continente,ListaTerr).

getVizinhos(ListaVizinhos):-
    get_global_variable(vizinhos,ListaVizinhos).


/*      addTerrJgdr: Adiciona um território a lista de territórios de um jogador. */


addTerrJogador(Player, Terr):-
    getTerritoriosJogador(Player,ListaTerr),
    append([Terr],ListaTerr,ListaTerrAtualizada),
    setTerritoriosJogador(Player,ListaTerrAtualizada).


/*      removeTerrJgdr: Remove um território da lista de territórios de um jogador. */


removeTerritorioJgdr(Jogador, Territorio):-
    getTerritoriosJogador(Jogador, Territorios),
    removeItem(Territorio, Territorios, TerritoriosAtualizado),
    setTerritoriosJogador(Jogador, TerritoriosAtualizado).

/*      mover_tropa_ctrl: Função para deslocar as tropas de um território a outro, desde
                      que cumpra as restrições. A função devolve uma lista contendo
                      os novos territórios após o deslocamento das tropas. */


moverTropaCtrl(TerritorioOrigem, TerritorioDestino, NumTropas) :-
    get_global_variable(territorios, Territorios),
    get_dict(TerritorioOrigem, Territorios, V1),
    V1 - NumTropas >= 1,
    moverTropaSrv(Territorios, TerritorioOrigem, TerritorioDestino, NumTropas, Resultado),
    set_global_variable(territorios, Resultado).


/*      ataque: Função responsável por fazer a ataque entre as tropas
             de dois territórios. Após finalizada, retorna uma lista
             com dois elementos que representa quantas tropas foram perdidas
             por cada território. */


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


/*      perdeTerritorio: Função responsável por retirar um território da lista de 
                territórios pertencentes a um jogador, caso todas as suas tropas 
                naquele respectivo território forem derrotadas. */


perdeTerritorio(JogadorGanhou,JogadorPerdeu,TropasPerdidasAt,TropasPerdidasDf,TerritorioOrigem, TerritorioAlvo):-
    get_global_variable(territorios, Territorios),
    TPDF is TropasPerdidasDf-1, 
    TPAT is TropasPerdidasAt+1,
    remove_tropa(Territorios, TerritorioAlvo, TPDF, TerritorioAlvoAtualizado), 
    (verificaTerrJgdr(JogadorPerdeu, TerritorioAlvo) -> removeTerritorioJgdr(JogadorPerdeu,TerritorioAlvo); true),
    remove_tropa(TerritorioAlvoAtualizado, TerritorioOrigem, TPAT, TerritorioOrigemAtualizado), 
    addTerrJogador(JogadorGanhou,TerritorioAlvo),
    set_global_variable(territorios, TerritorioOrigemAtualizado).


/*      adicionaTropa: Função responsável por adicionar uma quantidade de 
                                    tropas em um determinado território. */


adicionaTropa(N_tropas, Territorio) :-
    get_global_variable(territorios, Territorios),
    get_dict(Territorio, Territorios, QntdAtual),
    NovasTropas is QntdAtual + N_tropas,
    TerritoriosAtualizados = Territorios.put([Territorio:NovasTropas]),
    set_global_variable(territorios, TerritoriosAtualizados).


/* calculaTropas: Função responsável por calcular a quantidade de 
                            tropas que o jogador recebe por partida. */


calculaTropas(N_terr,N_recebe):-
    (N_terr > 1 -> N_recebe is N_terr // 2; N_recebe is 1).


/*  recebeTropas: Função responsável por distribuir as tropas para os 
                                    jogadores no início de cada partida. */


recebeTropas(Player,N_tropas):-
    getTerritoriosJogador(Player,ListaTerr),
    length(ListaTerr,N_terr),
    calculaTropas(N_terr,TropasRecebidas),
    N_tropas = TropasRecebidas.



/*  verificaTerrJgdr: Função responsável por verificar 
                        se um território pertence a um jogador. */


verificaTerrJgdr(Player, Terr):-
    getTerritoriosJogador(Player, ListaTerr),
    member(Terr,ListaTerr).


/* verificaVizinhos: Função responsável por verificar se 
                                    dois territórios são vizinhos. */


verificaVizinhos(Terr1,Terr2):-
    getVizinhos(ListaVizinhos),
    get_dict(Terr1,ListaVizinhos,Vizinhos),
    member(Terr2,Vizinhos).


/* verificaTropasTerritório: Função responsável por verificar se ao 
                        mover tropas de um territorio para outro, esse territorio 
                        irá ficar com pelo menos 1 tropa */


verificaTropasTerritorio(Terr, N_tropas) :-
    get_global_variable(territorios, Territorios),
    get_dict(Terr, Territorios, Tropas),
    Tropas - N_tropas >= 1.


/* imprimeGeral: Função responsável por imprimir os territórios de um jogador */


imprimeGeral(Jogador) :-
    getTerritoriosJogador(Jogador, Terr),
    auxImprimeGeral(Terr).


auxImprimeGeral([]).
auxImprimeGeral([H|T]) :-
    imprimeVizinhosETropasTerritorios(H),
    auxImprimeGeral(T).


/* imprimeVizinhosETropasTerritorios: Função responsável por imprimir 
                            o território dado e suas tropas, assim como seus 
                            vizinhos e suas respectivas tropas */


imprimeVizinhosETropasTerritorios(Territorio) :-
    get_global_variable(territorios, Territorios),
    get_dict(Territorio, Territorios, QntdAtual),
    getVizinhos(ListaVizinhos),
    get_dict(Territorio, ListaVizinhos, Vizinhos),
    auxTropasTerritorios(Vizinhos, Tropas),
    write("Territorio em posse: "), write(Territorio), write(" - Tropas: "), write(QntdAtual), nl,
    write("Vizinhos e Tropas: "), nl,
    auxImprimeVizinhosETropasTerritorios(Vizinhos, Tropas).


auxImprimeVizinhosETropasTerritorios([], []).
auxImprimeVizinhosETropasTerritorios([H1|T1], [H2|T2]) :-
    write(H1), write(" - Tropas: "), write(H2), nl,
    auxImprimeVizinhosETropasTerritorios(T1, T2).


auxTropasTerritorios([], []).
auxTropasTerritorios([H|T], [H1|T1]) :-
    get_global_variable(territorios, Territorios),
    get_dict(H, Territorios, H1),
    auxTropasTerritorios(T, T1).


