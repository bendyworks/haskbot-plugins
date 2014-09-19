{-# LANGUAGE OverloadedStrings #-}

module Plugins.FlipperSpec where

import qualified Data.Text as T
import Plugins.Flipper.Internal
import Test.Hspec
import Test.QuickCheck



test :: Spec
test = do
  describe "flipIt" $ do
    it "flips a string" $ do
      flipIt "flapjacks" `shouldBe` "(╯°□°)╯︵ sʞɔɐɾdɐlɟ"

    it "should add just 9 characters to the flipped string" $ do
      property $ \s -> let s' = T.pack s
                        in (T.length (flipIt s')) == (T.length s' + T.length "(╯°□°)╯︵ ")
