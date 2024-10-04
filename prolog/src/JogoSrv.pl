%  Move tropas de um território para outro, contanto que os dois sejam vizinhos e sejam dominados pelo mesmo jogador.

mover_tropa_srv(TerritorioOrigem, TerritorioDestino, NumTropas, NovoTerritorio) :-
    TerritorioOrigem = territorio(NomeTerritorio1, QuantidadeDeTropas1, Vizinhos1, Dono1),
    TerritorioDestino = territorio(NomeTerritorio2, QuantidadeDeTropas2, Vizinhos2, Dono2),

    QuantidadeDeTropas1Atualizado is QuantidadeDeTropas1 - NumTropas,
    (QuantidadeDeTropas1Atualizado =< 0 ;
    not(verifica_vizinhos(NomeTerritorio2, Vizinhos1)) ;
    not(verifica_territorio_jgr(TerritorioDestino, Dono1)) -> NovoTerritorio = none ;
    mover_tropa(TerritorioOrigem, TerritorioDestino, NumTropas, NovoTerritorio)).
