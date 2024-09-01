module Jogador where

{-
    Jogador: struct do jogador, responsável por guardar tanto a
             quantidade de territórios quanto
             a de continentes.
-}

data Jogador = Jogador {
    quantidadeTerritorios :: Int,
    quantidadeContinentes :: Int
}
