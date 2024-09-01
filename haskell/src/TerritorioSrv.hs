module TerritorioSrv where
{-
    Territorio Service: Responsável por conter as funções
                        referentes a um território.
-}

import Territorio

{-
    removeTropa: Função responsável por remover uma
                 quantidade x de tropas de um
                 determinado território criando um
                 novo território com a quantidade de
                 tropas reduzida.
-}

removeTropa :: Territorio -> Int -> Territorio
removeTropa ter n = Territorio {
    nomeTerritorio = nomeTerritorio ter,
    quantidadeDeTropas = quantidadeDeTropas ter - n,
    vizinhos = vizinhos ter,
    dono = dono ter
}

{-
    adicionaTropa: Função responsável por adicionar uma quantidade
                   x de tropas a um determinado território criando
                   um novo território com a quantidade de tropas
                   incrementada.
-}

adicionaTropa :: Territorio -> Int -> Territorio
adicionaTropa ter tropa = Territorio {
    nomeTerritorio = nomeTerritorio ter,
    quantidadeDeTropas = quantidadeDeTropas ter + tropa,
    vizinhos = vizinhos ter,
    dono = dono ter
}

{-
    moverTropa: Função responsável pelo deslocamento de uma
                quantidade x de tropas entre dois territórios.
                Retorna uma lista com esses novos territórios
                que têm quantidade de tropas modificada de
                acordo com o valor de tropas a ser movido.
-}

moverTropa :: Territorio -> Territorio -> Int -> [Territorio]
moverTropa terP terD num = removeTropa terP num : [adicionaTropa terD num]