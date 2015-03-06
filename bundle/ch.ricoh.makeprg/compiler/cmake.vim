" CMake compiler plugin
" Language: Many
" Maintainer: Rico Häuselmann

" Only load when no other compiler is loaded.
if exists("current_compiler")
    finish
endif
let current_compiler = "cmake"

let b:builddir = b:ricohBuildRoot . "/build"
if !isdirectory(b:builddir)
    call mkdir(b:builddir)
endif
if len(globpath(b:builddir, 'Makefile')) == 0
    execute "!cd " . b:builddir . " && cmake .."
endif

" default
let &l:makeprg = "cd " . b:builddir . " && make"
let b:makecall = "cd ". b:builddir . " && make && cd -"

" search leaf buildfile
"let s:lbf = b:ricohBuildLeaf . '/CMakeLists.txt'
let s:binpat = '"add_executable(\\zs.\\{-\\}\\ze .*' . expand('%:t') . '.*)"'
let s:subpat = '"add_subdirectory(\\zs.*\\ze)"'
let b:subdirs = ''
for buildf in b:ricohBuildFiles
    let subdirs = map(readfile(buildf), 'matchstr(v:val, ' . s:subpat . ')')
    for subdir in subdirs
        if subdir != ''
            if matchstr(b:ricohBuildLeaf, subdir) == subdir
                let b:subdirs = b:subdirs . subdir . '/'
            endif
        endif
    endfor
    let executable = join(map(readfile(buildf), 'matchstr(v:val, ' . s:binpat . ')'), '')
    if executable != ''
        let b:executable = executable
    endif
endfor

if exists("b:executable")
    let b:runcall  = b:ricohBuildRoot . '/build/' . b:subdirs . b:executable
else 
    let b:runcall = 'echo "no executable found in CMakeLists.txt!"'
endif
