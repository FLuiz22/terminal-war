module TerritorioSrv where

import Territorio
import Tropa

removeTropa :: Territorio -> Int -> Territorio
removeTropa a n = Territorio { 
    nome = (nome a), 
    tropas = take (length (tropas a) - n) (tropas a),
    vizinhos = (vizinhos a)
}


adicionaTropa :: Territorio -> [Tropa] -> Territorio
adicionaTropa ter tropa = Territorio {
    nome = (nome ter),
    tropas = (tropas ter) ++ tropa
}

moverTropa :: Territorio -> Territorio -> Int -> [Territorio]
moverTropa terP terD num = [removeTropa terP num] ++ [adicionaTropa terD (take num (tropas terP))]