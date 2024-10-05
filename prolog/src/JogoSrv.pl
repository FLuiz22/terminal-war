:- consult('../structs.pl').
:- consult('JogoCtrl.pl').

# Verifica caso um jogador já tenha vencido baseado nas condiçoes, um jogador esteja com 0 territórios,
# ou um já tenha conquistado de 2 continentes

verificaVitoriaSrv(Jogador1, Jogador2, Result) :-

    calculaQuantidadeTerritoriosJogador(Jogador1, QuantidadeTerritorios1),
    calculaQuantidadeTerritoriosJogador(Jogador2,QuantidadeTerritorios2),

    calculaQuantidadeContinentesJogador(Jogador1,QuantidadeContinentes1),
    calculaQuantidadeContinentesJogador(Jogador2, QuantidadeContinentes2),

    (   (QuantidadeTerritorios1 =:= 0, QuantidadeTerritorios2 > 0)-> Result = 'Jogador 2';
        (QuantidadeTerritorios2 =:= 0, QuantidadeTerritorios1 > 0)-> Result = 'Jogador 1';
        (QuantidadeContinentes1 >= 2, QuantidadeContinentes2 < 2)-> Result = "Jogador1";
        (QuantidadeContinentes2 >= 2, QuantidadeContinentes1 < 0)-> Result= "Jogador2";
        Result = none
    ).

calculaQuantidadeTerritoriosJogador(Jogador,R):-
    getTerritoriosJogador(Jogador,Terr),
    auxCalculaQuantidadeTerritoriosJogador(Terr,R).

auxCalculaQuantidadeTerritoriosJogador([],0).
auxCalculaQuantidadeTerritoriosJogador([H|T],R) :- auxCalculaQuantidadeTerritoriosJogador(T,R1), R is R1 + 1.

calculaQuantidadeContinentesJogador(Jogador,R) :-
    auxCalculaQuantidadeContinentesJogador(Jogador,0,R).

auxCalculaQuantidadeContinentesJogador(Jogador, Quant, R) :-
    (verificaDomContinente(Jogador, america) -> Quant1 is Quant + 1; Quant1 is Quant),
    (verificaDomContinente(Jogador, africa) -> Quant2 is Quant1 + 1; Quant2 is Quant1),
    (verificaDomContinente(Jogador, asia) -> Quant3 is Quant2 + 1; Quant3 is Quant2),
    (verificaDomContinente(Jogador, europa) -> Quant4 is Quant3 + 1; Quant4 is Quant3),
    (verificaDomContinente(Jogador, oceania) -> R is Quant4 + 1; R is Quant4).

verificaDomContinente(Player, Continente):-
    getTerritoriosJogador(Player,ListaTerrPlayer),
    getTerritoriosContinente(Continente, ListaTerrCont),
    sort(0,@=<,ListaTerrPlayer,ListaTerrPlaterSort),
    sort(0,@=<,ListaTerrCont,ListaTerrContSort),
    subset(ListaTerrContSort, ListaTerrPlaterSort).

verificaTerrJgdr(Player, Terr):-
    getTerritoriosJogador(Player, ListaTerr),
    member(Terr,ListaTerr).

