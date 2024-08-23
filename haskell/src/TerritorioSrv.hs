import Territorio

removeTropa :: Territorio -> Territorio
removeTropa a = Territorio { 
    nome = nome Territorio, 
    tropas = take (length (tropas Territorio) - 1) (tropas Territorio),
    vizinhos = vizinhos Territorio
}


adicionaTropa :: Territorio -> [Tropa] -> Territorio
adicionaTropa ter tropa = Territorio {
    nome = nome Territorio,
    tropas = (tropas Territorio) ++ tropa
}