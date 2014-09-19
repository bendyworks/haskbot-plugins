module Main where

import Test.Hspec
import Plugins.FlipperSpec (test)

main :: IO ()
main = hspec test
