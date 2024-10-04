/*  remove_tropa/2: Função responsável por remover uma 
                  quantidade x de tropas de um
                  determinado território criando um
                  novo território com a quantidade de
                  tropas reduzida. */

remove_tropa(Territorio, NumTropas, TerritorioAtualizado) :-
    Territorio = territorio(NomeTerritorio, QuantidadeDeTropas, Vizinhos, Dono),
    QuantidadeDeTropasAtualizado is QuantidadeDeTropas - NumTropas,
    TerritorioAtualizado = territorio(NomeTerritorio, QuantidadeDeTropasAtualizado, Vizinhos, Dono).




/*  adiciona_tropa/2: Função responsável por adicionar uma quantidade
                    x de tropas a um determinado território criando
                    um novo território com a quantidade de tropas
                    incrementada. */

adiciona_tropa(Territorio, NumTropas, TerritorioAtualizado) :-
    Territorio = territorio(NomeTerritorio, QuantidadeDeTropas, Vizinhos, Dono),
    QuantidadeDeTropasAtualizado is QuantidadeDeTropas + NumTropas,
    TerritorioAtualizado = territorio(NomeTerritorio, QuantidadeDeTropasAtualizado, Vizinhos, Dono).


    

/*  mover_tropa/3: Função responsável pelo deslocamento de uma
                 quantidade x de tropas entre dois territórios.
                 Retorna uma lista com esses novos territórios
                 que têm quantidade de tropas modificada de
                 acordo com o valor de tropas a ser movido. */

mover_tropa(TerritorioOrigem, TerritorioDestino, NumTropas, [TerritorioOrigemAtualizado, TerritorioDestinoAtualizado]) :-
    remove_tropa(TerritorioOrigem, NumTropas, TerritorioOrigemAtualizado),
    adiciona_tropa(TerritorioDestino, NumTropas, TerritorioDestinoAtualizado).

