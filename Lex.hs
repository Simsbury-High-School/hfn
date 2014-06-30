-- Lex.hs -- The Lexer for hfn

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

module Lex (fnLex) where

import Data
import Util

import Data.Char (isSpace)
import Data.List (find)
import Text.Regex.PCRE


-- The lex table contains pairs of regexps and functions. Lexing works by
-- finding the longest string that matches any regexp, then passing that string
-- as an argument to the function associated with that regexp. In the case of
-- two matches of the same length, then the one appearing earlier in the list is
-- chosen.

-- Right now, it just uses Strings as the regexps, but it would probably be more
-- efficient to use compiled expressions.
lexTable :: [(String, String -> Token)]
lexTable = [ ("\\A⇒", \s -> DoubleArrow)
           , ("\\A=>", \s -> DoubleArrow)
           , ("\\A\\(", \s -> OpenParen)
           , ("\\A\\)", \s -> CloseParen)
           , ("\\A|", \s -> Pipe)
           , ("\\A,", \s -> Comma)
           , ("\\A:", \s -> Colon)
           , ("\\A;", \s -> Semicolon)
           , ("\\A≔", \s -> ColonEquals)
           , ("\\A:=", \s -> ColonEquals)
           , ("\\A∀", \s -> Forall)
           , ("\\Aforall", \s -> Forall)
           , ("\\Aλ", \s -> Lambda)
           , ("\\A\\\\", \s -> Lambda)
           , ("\\AMatch", \s -> Match)
           , ("\\AEnd", \s -> End)
           , ("\\ALet", \s -> LetTok)
           , ("\\AIn", \s -> InTok)
           , ("\\AData", \s -> DataTok)
           , ("\\ADef", \s -> DefTok)
           , ("\\AImport", \s -> ImportTok)
           , ("\\AModule", \s -> ModuleTok)
           , ("\\ASyntax", \s -> SyntaxTok)
           , ("\\A\".*[^\\\\]\"", SymbolTok)
           , ("\\A[^⇒()|,:;≔λ\\\\\\s]+", SymbolTok) ]

-- Remove the comments from a string
stripComments :: String -> String
stripComments "" = ""
stripComments str
  | frontEq str "--!" = afterSeq "!--" str
  | frontEq str "--" = dropWhile (/='\n') str
  | otherwise = (head str) : stripComments (tail str)

-- Lex a string which has been stripped of comments
__fnLex :: String -> [Token]
__fnLex "" = []
__fnLex s = if null match
            then __fnLex (tail s)
            else (res match) : __fnLex (drop (length match) s)
  where fs = map fst lexTable
        matches = map ((s =~) :: String -> String) fs
        matchI = longestI matches
        match = matches !! matchI
        res = snd (lexTable !! matchI)

-- Lex a string
fnLex :: String -> [Token]
fnLex = __fnLex . stripComments
