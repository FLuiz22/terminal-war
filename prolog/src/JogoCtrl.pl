
/* mover_tropa_ctrl: Função para deslocar as tropas de um território a outro, desde
                      que cumpra as restrições. A função devolve uma lista contendo
                      os novos territórios após o deslocamento das tropas. */


mover_tropa_ctrl(TerritorioOrigem, TerritorioDestino, NumTropas, NovosTerritorios) :-
    mover_tropa_srv(TerritorioOrigem, TerritorioDestino, NumTropas, Resultado),
    (Resultado \= none -> NovosTerritorios = Resultado ;
    NovosTerritorios = [] ).