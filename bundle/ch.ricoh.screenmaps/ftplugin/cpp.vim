"if !has('python')
"    echo "Error: Requires vim compiled with +python"
"    finish
"endif
"
"function! Build()
"
"" start python code
"python << EOF
"import vim, os, re
"
"cb = vim.current.buffer
"path, name = os.path.split(cb.name)
"
"cmd = ''
"scmd = ''
"sss = 'call ScreenShellSend("{0}")'
"vc  = 'command! -nargs=0 {0} {1}<CR>'
"if 'CMakeLists.txt' in os.listdir(path):
"    up, cur = os.path.split(path)
"    while 'CMakeLists.txt' in os.listdir(up):
"        path = up
"        up, cur = os.path.split(path)
"    cmd = 'make'
"    path = '{}/build'.format(path)
"    mkp = 'make -C {}'.format(path)
"elif 'Makefile' in os.listdir(path):
"    up, cur = os.path.split(path)
"    while 'Makefile' in os.listdir(up):
"        path = up
"        up, cur = os.path.split(path)
"    cmd = 'make'
"    mkp = 'make -C {}'.format(path)
"else :
"    #cmd = 'make {}'.format(os.path.splitext(cb.name)[0])
"    #mkp = cmd
"    cmd = 'clang++ -o {} {}'.format(os.path.splitext(name)[0], name)
"    mkp = 'clang++ -o {} {}'.format(os.path.splitext(cb.name)[0], cb.name)
"
"#ncmd = '!{0}'.format(cmd)
"scmd = sss.format('cd {} && {}'.format(path, cmd))
"
"#vim.command('normal !echo \'{0}\''.format(ncmd))
"setcmd = sss.format('q')
"
"# set makeprg command
"mkpcmd = 'set makeprg={}'.format(re.sub(r' ', r'\\ ', mkp))
"
"#vim.command('command! -nargs=0 Build {0}<CR>'.format(cmd))
"vim.command(vc.format('ScreenBuild', scmd))
"vim.command(vc.format('ScreenExitTermios', setcmd))
"vim.command(mkpcmd)
"
"#end python code
"EOF
"
"endfunction
"
"call Build()

"nmap <Leader>m :Build<CR>
compiler g++
nmap <Leader>cm :ScreenShell<CR> :ScreenBuild<CR>
nmap <Leader>cM :ScreenShell!<CR> :ScreenBuild<CR>
nmap <Leader>cr :make!<CR> :ScreenShell<CR> :ScreenRun<CR>
nmap <Leader>cR :make!<CR> :ScreenShell!<CR> :ScreenRun<CR>
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
