{-# LANGUAGE OverloadedStrings #-}

module Plugins.Flipper.Internal where

import Data.Char (toLower)
import qualified Data.Map as M
import qualified Data.Text as T

import Network.Haskbot.Plugin
import Network.Haskbot.SlashCommand
import Network.Haskbot.Types

-- constants

name :: Command
name = setCommand "flip"

helpText :: T.Text
helpText = "Displeased with something? Type `haskbot flip [any other text]`\
           \ to have Haskbot cathartically toss what ails you."

flippedLets, uprightLets :: [Char]
uprightLets = "abcdefghijklmnopqrstuvwxyz.!?()[]<>"
flippedLets = "ɐqɔpǝɟƃɥᴉɾʞlɯuodbɹsʇnʌʍxʎz˙¡¿)(][><"

-- private functions

handler :: HandlerFn
handler slashCom =
  return $ case optText slashCom of
    Just(t) -> replySameChan slashCom $ flipIt t
    _       -> replyAsDM slashCom helpText

charMap :: M.Map Char Char
charMap = M.fromList $ zip (u ++ f) (f ++ u)
  where
    u = uprightLets
    f = flippedLets

flipIt :: T.Text -> T.Text
flipIt = T.append "(╯°□°)╯︵ " . flipChars

flipChars :: T.Text -> T.Text
flipChars "table" = "┻━┻"
flipChars str = T.reverse $ T.map flipLet str
  where
    flipLet l = M.findWithDefault l' l' charMap
      where
        l' = toLower l
