" GCC compiler plugin
" Language: C
" Maintainer: Rico Häuselmann

" Only load when no other compiler is loaded.
if exists("current_compiler")
    finish
endif
let current_compiler = "gcc"

" default make
setlocal makeprg=gcc\ %:p\ -o\ %:p:r
let b:makecall = "gcc ". expand("%:p") . " -o " . expand("%:p:r")
let b:runcall  = expand("%:p:r")
