{-# language TemplateHaskell #-}
{-# OPTIONS_GHC -O2 #-}

module G where

import Data.Word
import Language.Haskell.TH hiding (Type)
import Language.Haskell.TH qualified as TH

bounds :: [Word8]
bounds = [minBound..maxBound]

{-# INLINE utf8LengthByLeader #-}
utf8LengthByLeader :: Word8 -> Int
utf8LengthByLeader w
  | w < 0x80  = 1
  | w < 0xE0  = 2
  | w < 0xF0  = 3
  | otherwise = 4

useLeader :: [Word8] -> Q [Dec]
useLeader xs = do
  return
    [
      DataD [] (mkName "IntEnum") [] Nothing cons_ []
    ]
  where
    cons_ = fmap go xs
    go name_ = NormalC (mkName $ "I" <> show name_ <> show (utf8LengthByLeader name_) <> "R") []
