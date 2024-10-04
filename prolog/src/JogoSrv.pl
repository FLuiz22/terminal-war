verifica_vitoria(Jogador1, Jogador2, Result) :-
    nb_getval(Jogador1, TerritoriosJogador1),
    nb_getval(Jogador2, TerritoriosJogador2),

    QuantidadeTerritorios1 is length(TerritoriosJogador1),
    QuantidadeTerritorios2 is length(TerritoriosJogador2),

    calculaQuantidadeContinentesJogador(Jogador1,QuantidadeContinentes1),
    calculaQuantidadeContinentesJogador(Jogador2, QuantidadeContinentes2),

    (   (QuantidadeTerritorios1 =:= 0)->Result = 'Jogador 2';
        (QuantidadeTerritorios2 =:= 0)->Result = 'Jogador 1';
        (QuantidadeContinentes1 >= 2)->Result = "Jogador1";
        (QuantidadeContinentes2 >= 2)->Result= "Jogador2";
        Result = none
    ).

calculaQuantidadeContinentesJogador(Jogador, R) :-
    nb_getval(Jogador, TerritoriosJogador),
    findall(Continente, possuiContinente(Jogador, Continente), ContinentesControlados),
    length(ContinentesControlados, R).

# Verifica se um jogador possui um continente (Possui todos os territorios que compoem um continente)
possuiContinente(Jogador, Continente) :-
    nb_getval(Jogador, TerritoriosJogador),
    nb_getval(Continente, TerritoriosContinente),
    aux_possui_continente(TerritoriosJogador,TerritoriosContinente).

auxPossuiContinente([H|T],TerritoriosContinente) :- 
    member(H,TerritoriosContinente), 
    auxPossuiContinente(T,TerritoriosContinente).