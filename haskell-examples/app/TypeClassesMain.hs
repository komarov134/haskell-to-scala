module Main where

import           TypeClasses (AnotherExample (..), Example (..), Test (..))

main :: IO ()
main = do
  putStrLn . test . Example        $ "this is example "
  putStrLn . test . AnotherExample $ "this is another example "
