function! BuildRunInVim()
    if exists("b:runcall")
        make
        execute "!" . b:runcall
    else
        echo "Run not supported by the current compiler" 
        echo "Trying to find a better one..."
        call getcc#Getbuildsys()
        if b:ricohBuildSys != "None"
            execute "compiler! " . b:ricohBuildSys
            echo "Set compiler to " . b:ricohBuildSys
        endif
    endif
endfunction

function! BuildInScreen()
    if exists("b:makecall")
        ScreenShell
        call ScreenShellSend(b:makecall)
    else
        echo "ScreenBuild not supported by the current compiler"
        echo "Trying to find a better one..."
        call getcc#Getbuildsys()
        if b:ricohBuildSys != "None"
            compiler b:RicohBuildSys
        endif
    endif
endfunction

command! -nargs=0 Run call BuildRunInVim()
command! -nargs=0 ScreenBuild call ScreenShellSend(b:makecall)
command! -nargs=0 ScreenRun call ScreenShellSend(b:runcall)
