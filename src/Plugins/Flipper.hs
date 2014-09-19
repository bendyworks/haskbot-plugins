{-# LANGUAGE OverloadedStrings #-}

module Plugins.Flipper (register) where

import qualified Data.Text as T

import Network.Haskbot.Plugin
import Network.Haskbot.Types

import Plugins.Flipper.Internal

-- public functions

register :: T.Text -> Plugin
register = Plugin name helpText handler . setToken
