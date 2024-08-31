import System.Random
import Data.List (delete)

rollDice :: IO Int
rollDice = do randomRIO (1,6)

batalha :: [Int] -> [Int] -> [Int]
batalha d_at d_df
    | m1 > m2 && not (null d_m1)  && not (null d_m2) = zipWith (+) [0,-1] (batalha d_m1 d_m2)
    | m1 <= m2 && not (null d_m1) && not (null d_m2) = zipWith (+) [-1,0] (batalha d_m1 d_m2)
    | m1 > m2 && (null d_m1 || null d_m2) = [0,-1]
    | m1 <= m2 && (null d_m1 || null d_m2) = [-1,0]
    where m1 = maximum d_at
          m2 = maximum d_df
          d_m1 = delete m1 d_at
          d_m2 = delete m2 d_df

main :: IO()
main = do
    t1 <- getLine
    t2 <- getLine

    num1 <- rollDice :: IO Int
    num2 <- rollDice :: IO Int
    num3 <- rollDice :: IO Int
    num4 <- rollDice :: IO Int
    num5 <- rollDice :: IO Int
    num6 <- rollDice :: IO Int
    
    let t_at = read t1 :: Int
    let t_df = read t2 :: Int
    let a = [num1,num2,num3]
    let b = [num4,num5,num6]

    if t_at == 3 && t_df == 3 then print(batalha a b)
    else if t_at == 2 && t_df == 3 then print(batalha (tail a) b)
    else if t_at == 3 && t_df == 2 then print(batalha a (tail b))
    else if t_at == 2 && t_df == 2 then print(batalha (tail a) (tail b))
    else if t_at == 2 && t_df == 1 then print(batalha (tail a) [head b])
    else if t_at == 1 && t_df == 2 then print(batalha [head a] (tail b))
    else if t_at == 1 && t_df == 1 then print(batalha [head a] [head b])
    else if t_at == 3 && t_df == 1 then print(batalha a [head b])
    else print(batalha [head a] b)
