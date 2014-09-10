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
namestem, ext = os.path.splitext(name)

cmd = ''
if 'CMakeLists.txt' in os.listdir(path):
    up, cur = os.path.split(path)
    while 'CMakeLists.txt' in os.listdir(up):
        path = up
        up, cur = os.path.split(path)
    cmd = 'cd {0}/build && make'.format(path)
else :
    tex = name
    aux = namestem+'.aux'
    pdf = namestem+'.pdf'
    bib_cmd = ''
    if any(['.bib' in fname for fname in os.listdir(path)]):
        bib_cmd = '&& bibtex {0}'.format(namestem)
    cmd = 'cd {0} && pdflatex {1} {2} && pdflatex {1} && pdflatex -synctex=1 {1} && open {3}'
    cmd = cmd.format(path, tex, bib_cmd, pdf)

scmd = 'call ScreenShellSend("{0}")'.format(cmd)

vim.command('command! -nargs=0 ScreenBuild {0}<CR>'.format(scmd))
EOF
endfunction

call Build()

nmap <Leader>cm :ScreenShell<CR> :ScreenBuild<CR>
nmap <Leader>cM :ScreenShell!<CR> :ScreenBuild<CR>
"nmap <Leader>cm :call ScreenShell<CR> ScreenShellSend("cd <C-r>=expand("%:p:h")<CR> && pdflatex -synctex=1 <C-r>=expand("%:p")<CR> && open <C-r>=expand("%:p:r")<CR>.pdf")<CR>
