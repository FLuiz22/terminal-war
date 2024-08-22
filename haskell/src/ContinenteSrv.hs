import System.Random

rollDice :: IO Int
rollDice = randomRIO (1,6)

main :: IO()
main = do
    g <- newStdGen
    numero <- rollDice
    print(numero)