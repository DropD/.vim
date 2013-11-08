if !has('python')
    echo "Error: Requires vim compiled with +python"
    finish
endif

function! Build()

" start python code
python << EOF
import vim, os

cb = vim.current.buffer
path, name = os.path.split(cb.name)

cmd = ''
scmd = ''
sss = 'call ScreenShellSend("{0}")'
vc  = 'command! -nargs=0 {0} {1}<CR>'
if 'Makefile' in os.listdir(path):
    up, cur = os.path.split(path)
    while 'Makefile' in os.listdir(up):
        path = up
        up, cur = os.path.split(path)
    cmd = 'cd {0} && make'.format(path)
elif 'CMakeLists.txt' in os.listdir(path):
    up, cur = os.path.split(path)
    while 'CMakeLists.txt' in os.listdir(up):
        path = up
        up, cur = os.path.split(path)
    cmd = 'cd {0}/build && make'.format(path)
else :
    cmd = 'cd {0} && clang++ -o main {1}'.format(path, name)

#ncmd = '!{0}'.format(cmd)
scmd = sss.format(cmd)

#vim.command('normal !echo \'{0}\''.format(ncmd))
setcmd = sss.format('q')

#vim.command('command! -nargs=0 Build {0}<CR>'.format(cmd))
vim.command(vc.format('ScreenBuild', scmd))
vim.command(vc.format('ScreenExitTermios', setcmd))

#end python code
EOF

endfunction

call Build()

"nmap <Leader>m :Build<CR>
nmap <Leader>cm :ScreenShell<CR> :ScreenBuild<CR>
nmap <Leader>cM :ScreenShell!<CR> :ScreenBuild<CR>
nmap <Leader>ce :ScreenExitTermios<CR>

" Old Version.
"
"function! Build()
"    if filereadable("%:p:h/Makefile")
"        :call ScreenShellSend("cd <C-r>=expand('%:p:h')<CR> && make")<CR>
"    elseif filereadable("%:p:h/../CMakeLists.txt")
"        :call ScreenShellSend("cd <C-r>=expand('%:p:h/../build')<CR> && make")<CR>
"    else 
"        :call ScreenShellSend("cd <C-r>=expand('%:p:h')<CR> && clang++ -o main <C-r>=expand('%')<CR>")<CR>
"    endif
"endfunction
