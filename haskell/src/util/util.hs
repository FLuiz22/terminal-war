module Util where

{-
    Util: Responsável por conter funções genéricas que auxiliam
          em questões gerais do código como conversão de tipo ou
          número randômico.
-}

import System.Random

{-
    maybeToString: Converte o tipo Maybe String para String.
-}

maybeToString :: Maybe String -> String
maybeToString Nothing = ""
maybeToString (Just x) = x

{-
    maybeTerList: Converte o tipo Maybe [a] para [a], ou seja,
                  um Maybe lista para uma lista.
-}

maybeTerList :: Maybe [a] -> [a]
maybeTerList Nothing = []
maybeTerList (Just x) = x

{-
    rollDice: Usa a função random que gera números aleatórios
              para simular o rolar de um dado.
-}

rollDice :: IO Int
rollDice = do randomRIO (1,6)