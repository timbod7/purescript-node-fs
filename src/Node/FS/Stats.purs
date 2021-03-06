module Node.FS.Stats
  ( Stats (..)
  , StatsObj (..)
  , isFile
  , isDirectory
  , isBlockDevice
  , isCharacterDevice
  , isFIFO
  , isSocket
  , isSymbolicLink
  , accessedTime
  , modifiedTime
  , statusChangedTime
  ) where

import Prelude
import Data.Date
import Data.Function
import Data.Maybe.Unsafe (fromJust)

type StatsObj =
  { dev :: Number
  , mode :: Number
  , nlink :: Number
  , uid :: Number
  , gid :: Number
  , rdev :: Number
  , ino :: Number
  , size :: Number
  , atime :: JSDate
  , mtime :: JSDate
  , ctime :: JSDate
  , isFile :: Fn0 Boolean
  , isDirectory :: Fn0 Boolean
  , isBlockDevice :: Fn0 Boolean
  , isCharacterDevice :: Fn0 Boolean
  , isFIFO :: Fn0 Boolean
  , isSocket :: Fn0 Boolean
  }

-- |
-- Stats wrapper to provide a usable interface to the underlying properties and methods.
--
data Stats = Stats StatsObj

foreign import showStatsObj :: StatsObj -> String

instance showStats :: Show Stats where
  show (Stats o) = "Stats " ++ showStatsObj o

foreign import statsMethod :: Fn2 String StatsObj Boolean

isFile :: Stats -> Boolean
isFile (Stats s) = runFn2 statsMethod "isFile" s

isDirectory :: Stats -> Boolean
isDirectory (Stats s) = runFn2 statsMethod "isDirectory" s

isBlockDevice :: Stats -> Boolean
isBlockDevice (Stats s) = runFn2 statsMethod "isBlockDevice" s

isCharacterDevice :: Stats -> Boolean
isCharacterDevice (Stats s) = runFn2 statsMethod "isCharacterDevice" s

isFIFO :: Stats -> Boolean
isFIFO (Stats s) = runFn2 statsMethod "isFIFO" s

isSocket :: Stats -> Boolean
isSocket (Stats s) = runFn2 statsMethod "isSocket" s

isSymbolicLink :: Stats -> Boolean
isSymbolicLink (Stats s) = runFn2 statsMethod "isSymbolicLink" s

accessedTime :: Stats -> Date
accessedTime (Stats s) = fromJust (fromJSDate s.atime)

modifiedTime :: Stats -> Date
modifiedTime (Stats s) = fromJust (fromJSDate s.mtime)

statusChangedTime :: Stats -> Date
statusChangedTime (Stats s) = fromJust (fromJSDate s.ctime)
