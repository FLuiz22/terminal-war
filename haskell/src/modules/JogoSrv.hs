import Jogador
import Data.Maybe (Maybe(Nothing))

verificaVitoria :: Jogador -> Jogador -> Maybe Jogador
verificaVitoria jogador1 jogador2
    | territorios jogador1 == 0 && territorios jogador2 > 0 =  Just jogador2
    | territorios jogador2 == 0 && territorios jogador1 > 0 = Just jogador1
    | continentes jogador1 >= 2 && continentes jogador2 < 2 = Just jogador2
    | continentes jogador2 >= 2 && continentes jogador1 < 2 = Just jogador1
    | otherwise = Nothing


    

