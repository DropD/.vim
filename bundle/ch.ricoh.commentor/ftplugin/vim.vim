if !has('python')
    echo "Error: Requires vime compiled with +python"
    finish
endif

let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let s:comm = s:path.'/commentor.py'

execute "pyfile ".s:comm

python << EOPY
if commentor_vim not in vars():
    commentor_vim = Commentor('"')
EOPY

nmap <Leader>' :py commentor_vim.toggle_comment() <CR>
vmap <Leader>' :py commentor_vim.toggle_comment() <CR>

