-- Util.hs -- A grab-bag of general-purpose utility functions

-- Copyright 2014 Jack Pugmire
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--    http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

module Util where

import Data

import Data.Char (ord)


-- Tell if the beginning of a list is equal to another list, e.g.
-- frontEq "he" "hello" => True
frontEq :: Eq a => [a] -> [a] -> Bool
frontEq [] _ = True
frontEq _ [] = True
frontEq (x:xs) (y:ys) = x == y && frontEq xs ys

-- Drop members of a list until a specific sequence is encountered. That
-- sequence is also dropped.
afterSeq :: Eq a => [a] -> [a] -> [a]
afterSeq xs [] = []
afterSeq xs ys = if frontEq xs ys
                     then drop (length xs) ys
                     else afterSeq xs (tail ys)

-- Take members from a list as long as the resulting sequence matches the given
-- predicate.
takeWhileSeq :: ([a] -> Bool) -> [a] -> [a]
takeWhileSeq f xs = iter 1
  where l = length xs
        iter i
          | i > l = xs
          | f (take i xs) = iter (i + 1)
          | otherwise = take (i - 1) xs

-- find the index of the first longest member in a list of lists
longest :: [[a]] -> [a]
longest = snd . (foldl f (0,[]))
  where f (l,xs) ys = let l' = length ys
                      in if l' > l
                         then (l',ys)
                         else (l,xs)

-- find the index of the first longest member in a list of lists
longestI :: [[a]] -> Int
longestI xs = snd (foldl f (0,0) (zip xs [0..]))
  where f (l,i) (xs,i') = let l' = length xs
                          in if l' > l
                             then (l',i')
                             else (l,i)


-- convert a string to a Sym
toSym :: String -> Sym
toSym str = Sym str (hashStr str)

-- a Perrin prime number taken from wikipedia
hashPrime :: Integer
hashPrime = 187278659180417234321

-- Hash a string. I just made up this algorithm, but it seems to work pretty
-- well.
hashStr :: String -> Int
hashStr str = fromInteger (foldl ffunc 0 str)
  where ffunc i c = (i * hashPrime) + toInteger (ord c)
