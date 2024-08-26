module TerritorioSrv where

import Territorio
import Tropa

removeTropa :: Territorio -> Territorio
removeTropa a = Territorio { 
    nome = (nome a), 
    tropas = take (length (tropas a) - 1) (tropas a),
    vizinhos = (vizinhos a)
}


adicionaTropa :: Territorio -> [Tropa] -> Territorio
adicionaTropa ter tropa = Territorio {
    nome = (nome ter),
    tropas = (tropas ter) ++ tropa
}