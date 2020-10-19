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

    -- | * (&) is used when you want to update something in object
    --   * mapped is used with (&) -- to look at each element of list separately
    --   * dAge here works as a filter to select only those pets which have this field
    --     AND to look at this field
    --   * (+~) = add
    --
    let withAllDogsOlder = examplePerson & pPets . mapped . dAge +~ 1
    print withAllDogsOlder

    -- | (<>~) = concatenate
    let withNewCat = examplePerson & pPets <>~ [ Cat Nothing 1 "Lilo" ]
    print withNewCat

    -- | * (^..) is used with traverse to look at each element of list separately
    --   * dBreed here works as a filter to select only those pets which have this field
    --     AND to look at this field
    --   * _Just here works as a filter to select only Just fields
    --
    let allDogBreeds = examplePerson ^.. pPets . traverse . dBreed . _Just
    print allDogBreeds

    -- | * (^?) is used when you want to look at the field which might not be presented
    --     (considering presence of the last lens)
    --   * _Diving is a prism which retrieves field from data 'Diving'
    --
    let divingExperience = examplePerson ^? pInterests . traverse . _Diving
    print divingExperience

    -- | * (%~) = apply a function in setter
    --   * (^?! _Just) = fromJust
    --   * to = apply a function in getter
    let withoutDiving = examplePerson & pInterests %~ delete (divingExperience ^?! _Just . to Diving)
    print withoutDiving
