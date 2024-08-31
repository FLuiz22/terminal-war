module Util where
import System.Random

maybeToList :: Maybe [a] -> [a]
maybeToList Nothing = []
maybeToList (Just x) = x

rollDice :: IO Int
rollDice = do randomRIO (1,6)
