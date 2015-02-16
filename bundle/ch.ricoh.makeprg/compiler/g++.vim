" G++ compiler plugin
" Language: C++
" Maintainer: Rico Häuselmann

" Only load when no other compiler is loaded.
if exists("current_compiler")
    finish
endif
let current_compiler = "g++"

" default make
setlocal makeprg=g++\ %:p\ -o\ %:p:r
let b:makecall = "g++ ". expand("%:p") . " -o " . expand("%:p:r")
let b:runcall  = expand("%:p:r")
