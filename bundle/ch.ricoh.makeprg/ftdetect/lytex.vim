function! s:setmake()
    if exists("b:makecall")
    else
        call getcc#Getbuildsys()
        if b:ricohBuildSys != "None"
            execute "compiler! " . b:ricohBuildSys
        else
            echo 'NotYetImplemented: set fallback lytex compiler'
        endif
    endif
endfunction

au BufRead,BufNewFile *.lytex call s:setmake()
