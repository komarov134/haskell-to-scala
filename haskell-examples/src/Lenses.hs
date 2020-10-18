{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}

module Lenses where

import           Control.Lens (makeLenses, makePrisms)
import           Data.Text    (Text)
import           GHC.Generics (Generic)

data Interest = Diving  { _dExperience :: Int
                        }
              | Sport   { _sName       :: Text
                        , _sExperience :: Int
                        }
              | Tourism { _tName :: Text
                        }
  deriving (Show, Eq, Generic)

makeLenses ''Interest
makePrisms ''Interest

data Pet = Dog { _dBreed :: Maybe Text
               , _dAge   :: Int
               , _dName  :: Text
               }
         | Cat { _cBreed :: Maybe Text
               , _cAge   :: Int
               , _cName  :: Text
               }
  deriving (Show, Eq, Generic)

makeLenses ''Pet
makePrisms ''Pet

data Person =
     Person { _pName      :: Text
            , _pAge       :: Int
            , _pInterests :: [Interest]
            , _pPets      :: [Pet]
            }
  deriving (Show, Eq, Generic)

makeLenses ''Person

examplePerson :: Person
examplePerson = Person "Kate" 20 interests pets
  where
    pets = [ Dog (Just "Australian Shepherd Dog") 2  "Runa"
           , Dog Nothing                          14 "Bobik"
           , Cat Nothing                          3  "Miya"
           ]
    interests = [ Diving 2
                , Tourism "hitch-hiking"
                ]
