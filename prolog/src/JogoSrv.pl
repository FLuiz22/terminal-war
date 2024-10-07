:- consult('./TerritorioSrv.pl').

/*      verificaVitoriaSrv: Verifica caso um jogador já tenha vencido, se sim, 
                        o jogador será retornado, se nao, será retornado None. */


verificaVitoriaSrv(Jogador1, Jogador2, Result, America, Europa, Asia, Africa, Oceania) :-

    calculaQuantidadeTerritoriosJogador(Jogador1, QuantidadeTerritorios1),
    calculaQuantidadeTerritoriosJogador(Jogador2,QuantidadeTerritorios2),

    calculaQuantidadeContinentesJogador(Jogador1, 0, America, Africa, Asia, Europa, Oceania, QuantidadeContinentes1),
    calculaQuantidadeContinentesJogador(Jogador2, 0, America, Africa, Asia, Europa, Oceania, QuantidadeContinentes2),

    (   (QuantidadeTerritorios1 =:= 0, QuantidadeTerritorios2 > 0)-> Result = "Jogador 2";
        (QuantidadeTerritorios2 =:= 0, QuantidadeTerritorios1 > 0)-> Result = "Jogador 1";
        (QuantidadeContinentes1 >= 2, QuantidadeContinentes2 < 2)-> Result = "Jogador 1";
        (QuantidadeContinentes2 >= 2, QuantidadeContinentes1 < 0)-> Result= "Jogador 2";
        Result = none
    ).


/*      calculaQuantidadeDeTerritorios: Calcula 
                            a quantidade de territórios que um jogador possui */


calculaQuantidadeTerritoriosJogador(Jogador, R):-
    length(Jogador,R).


/*      calculaQuantidadeContinentesJogador: Calcula a quantidade 
                                    de continentes que um jogador possui */


calculaQuantidadeContinentesJogador(Jogador, Quant, America, Africa, Asia, Europa, Oceania, R) :-
    (subset(America, Jogador) -> Quant1 is Quant + 1; Quant1 is Quant),
    (subset(Africa, Jogador) -> Quant2 is Quant1 + 1; Quant2 is Quant1),
    (subset(Asia, Jogador) -> Quant3 is Quant2 + 1; Quant3 is Quant2),
    (subset(Europa, Jogador) -> Quant4 is Quant3 + 1; Quant4 is Quant3),
    (subset(Oceania, Jogador) -> R is Quant4 + 1; R is Quant4).


/*      moveTropaSrv: Move tropas de um território para outro, 
                            contanto que os dois sejam vizinhos e sejam dominados pelo mesmo jogador. */


moverTropaSrv(Territorios, TerritorioOrigem, TerritorioDestino, NumTropas, TerritorioAt) :-
    mover_tropa(Territorios, TerritorioOrigem, TerritorioDestino, NumTropas, TerritorioAt).


/*      somaLista: Soma os elementos de duas listas */


somaLista([H1,T1], [H2,T2], [S,R]) :- 
    S is H1 + H2,
    R is T1 + T2.


/*      sameList: Verifica se duas listas são iguais */


sameList([], []).
sameList([H1|R1], [H2|R2]):-
    H1 = H2,
    sameList(R1, R2).


/*      removeItem: Remove o item de uma lista */


removeItem(Y, [Y], []).
removeItem(X, [X|Y], Y).
removeItem(X, [Y|List], [Y|List1]):- removeItem(X,List,List1).


/*      rollDices: sorteia os números dos dados */


rollDices(N,R):-
    N =:= 3 -> (random(1,7,R1),random(1,7,R2),random(1,7,R3),R=[R1,R2,R3]);
    (N > 1 -> (random(1,7,R1),random(1,7,R2), R=[R1,R2]); (random(1,7,R1), R = [R1])).


/*      batalhas: recebe os números sorteados dos dados do ataque e da defesa,
                                é feita a verificação e o território perdedor recebe uma tupla com os territórios perdidos */


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
    