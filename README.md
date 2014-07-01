hfn FN Interpreter
==================

This directory contains the source code for hfn, an interpreter for the FN
Programming Language. hfn is written in the Haskell programming language. To
learn more about FN, consult the FN Doc GitHub repository which may be cloned
with

    git clone git@github.com:fnlang/fndoc.git


Documentation
-------------

Documentation for hfn currently does not exist outside of a physical notebook
which can be found on the author's desk. Work is underway to transfer the
contents of said notebook to a more organized (and legible) series of LaTeX
documents, which will eventually be available on the FN Doc GitHub repository.


Building and Installing
-----------------------

hfn depends upon either the regex-pcre package which is available from Hackage
at <http://hackage.haskell.org/package/regex-pcre>. It can be installed using
cabal install like so:

    cabal install regex-pcre

hfn does not have an executable target presently. Its source files can be
compiled with the Glaskell Haskell Compiler, <https://www.haskell.org/ghc/>.


Version
-------

This directory contains version 1.0-git of the source code for hfn.

The latest version of hfn may be obtained with git, using

    git clone git@github.com:fnlang/hfn.git


Licensing
---------

hfn is free software licensed under the Apache License, Version 2.0. For more
information, see the file COPYING.


Authors
-------

This version of hfn is the sole work of Jack Puggles.
