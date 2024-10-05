:- consult(['../structs.pl', './JogoSrv.pl']).


/* mover_tropa_ctrl: Função para deslocar as tropas de um território a outro, desde
                      que cumpra as restrições. A função devolve uma lista contendo
                      os novos territórios após o deslocamento das tropas. */


mover_tropa_ctrl(TerritorioOrigem, TerritorioDestino, NumTropas, Ter) :-
    get_global_variable(territorios, Territorios),
    get_dict(TerritorioOrigem, Territorios, V1),
    V1 - NumTropas >= 1,
    mover_tropa_srv(Territorios, TerritorioOrigem, TerritorioDestino, NumTropas, Resultado),
    set_global_variable(territorios, Resultado).