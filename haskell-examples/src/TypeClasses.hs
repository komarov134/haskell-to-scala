{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications    #-}

module TypeClasses where

class HasString a where
  someString :: a -> String

class HasString a => Test a where
  someInt :: Int

  test :: a -> String
  test t = someString t <> show (someInt @a)

data Example = Example String

data AnotherExample = AnotherExample String

instance HasString Example where
  someString (Example s) = s

instance HasString AnotherExample where
  someString (AnotherExample s) = s

instance Test Example where
  someInt = 1

instance Test AnotherExample where
  someInt = 2
