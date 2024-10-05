/*  remove_tropa/2: Função responsável por remover uma 
                  quantidade x de tropas de um
                  determinado território criando um
                  novo território com a quantidade de
                  tropas reduzida. */

remove_tropa(Territorios, Territorio, NumTropas, TerritorioAtualizado) :-
    get_dict(Territorio, Territorios, QntdAtual),
    QuantidadeDeTropasAtualizado is QntdAtual - NumTropas,
    TerritorioAtualizado = Territorios.put([Territorio:QuantidadeDeTropasAtualizado]).

/*  adiciona_tropa/2: Função responsável por adicionar uma quantidade
                    x de tropas a um determinado território criando
                    um novo território com a quantidade de tropas
                    incrementada. */

adiciona_tropa(Territorios, Territorio, NumTropas, TerritorioAtualizado) :-
    get_dict(Territorio, Territorios, QntdAtual),
    QuantidadeDeTropasAtualizado is QntdAtual + NumTropas,
    TerritorioAtualizado = Territorios.put([Territorio:QuantidadeDeTropasAtualizado]).

/*  mover_tropa/3: Função responsável pelo deslocamento de uma
                 quantidade x de tropas entre dois territórios.
                 Retorna uma lista com esses novos territórios
                 que têm quantidade de tropas modificada de
                 acordo com o valor de tropas a ser movido. */

mover_tropa(Territorios, TerritorioOrigem, TerritorioDestino, NumTropas, TerritoriosFim) :-
    remove_tropa(Territorios, TerritorioOrigem, NumTropas, TerritorioAtualizado),
    adiciona_tropa(TerritorioAtualizado, TerritorioDestino, NumTropas, TerritoriosFim).