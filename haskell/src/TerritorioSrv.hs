module TerritorioSrv where

import Territorio

removeTropa :: Territorio -> Int -> Territorio
removeTropa ter n = Territorio {
    nomeTerritorio = nomeTerritorio ter,
    quantidadeDeTropas = quantidadeDeTropas ter - n,
    vizinhos = vizinhos ter,
    dono = dono ter
}


adicionaTropa :: Territorio -> Int -> Territorio
adicionaTropa ter tropa = Territorio {
    nomeTerritorio = nomeTerritorio ter,
    quantidadeDeTropas = quantidadeDeTropas ter + tropa,
    vizinhos = vizinhos ter,
    dono = dono ter
}

moverTropa :: Territorio -> Territorio -> Int -> [Territorio]
moverTropa terP terD num = removeTropa terP num : [adicionaTropa terD num]