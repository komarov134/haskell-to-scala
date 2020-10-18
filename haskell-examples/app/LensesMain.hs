{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Control.Lens (mapped, to, (%~), (&), (+~), (<>~), (^..), (^?),
                               (^?!), _Just)
import           Data.List    (delete)
import           Lenses       (Interest (..), Pet (..), dAge, dBreed,
                               examplePerson, pInterests, pPets, _Diving)

main :: IO ()
main = do
    print examplePerson

    let withAllDogsOlder = examplePerson & pPets . mapped . dAge +~ 1
    print withAllDogsOlder

    let withNewCat = examplePerson & pPets <>~ [ Cat Nothing 1 "Lilo" ]
    print withNewCat

    let allDogBreeds = examplePerson ^.. pPets . traverse . dBreed . _Just
    print allDogBreeds

    let divingExperience = examplePerson ^? pInterests . traverse . _Diving
    print divingExperience

    let withoutDiving = examplePerson & pInterests %~ delete (divingExperience ^?! _Just . to Diving)
    print withoutDiving
