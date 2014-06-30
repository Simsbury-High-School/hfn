-- Data.hs -- Various datatypes for hfn

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

module Data where

import Data.Maybe


-- A symbol in FN (used for names)
data Sym = Sym String Int  -- The symbol as a string followed by its hash value

instance Show Sym where
  show (Sym s _) = s


-- A token from the lexer
data Token = DoubleArrow
           | OpenParen
           | CloseParen
           | Pipe
           | Comma
           | Colon
           | Semicolon
           | ColonEquals
           | Forall
           | Lambda
           | Match
           | End
           | LetTok
           | InTok
           | DataTok
           | DefTok
           | ImportTok
           | ModuleTok
           | SyntaxTok
           | SymbolTok String
           deriving Show
