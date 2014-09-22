{-# LANGUAGE OverloadedStrings #-}

module Main where

import Network.Haskbot.Internal.Server (app)
import Network.Haskbot.Internal.Environment (bootstrap)
import Network.Haskbot.Config
import Network.Wai (Application)
import Test.Hspec
import Test.Hspec.Wai

token :: String
token = "ABCXYZ"

conf :: Config
conf = Config 8080 "http://localhost" token

app' :: IO Application
app' = do
  env <- bootstrap conf
  return $ app env []

appTest :: Spec
appTest = with app' $ do
  describe "GET /" $ do
    it "responds with Forbidden" $ do
      get "/" `shouldRespondWith` "Forbidden" {matchStatus = 403}

main :: IO ()
main = hspec appTest
