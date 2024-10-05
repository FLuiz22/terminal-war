:- consult(['../structs.pl', './JogoSrv.pl']).


/* mover_tropa_ctrl: Função para deslocar as tropas de um território a outro, desde
                      que cumpra as restrições. A função devolve uma lista contendo
                      os novos territórios após o deslocamento das tropas. */


mover_tropa_ctrl(TerritorioOrigem, TerritorioDestino, NumTropas) :-
    get_global_variable(territorios, Territorios),
    get_dict(TerritorioOrigem, Territorios, V1),
    V1 - NumTropas >= 1,
    mover_tropa_srv(Territorios, TerritorioOrigem, TerritorioDestino, NumTropas, Resultado),
    set_global_variable(territorios, Resultado).

ataque(N_TropasAt, TerrOrigem, TerrAlvo, TropasPerdidasAt, TropasPerdidasDf) :-
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
    remove_tropa(Territorios, TerrOrigem, TropasPerdidasAt, N1),
    remove_tropa(N1, TerrAlvo, TropasPerdidasDf, N2),
    set_global_variable(territorios, N2).
