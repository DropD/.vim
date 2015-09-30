if !has('python')
    echo "Error: Requires vime compiled with +python"
    finish
endif

let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let s:comm = s:path.'/commentor.py'

execute "pyfile ".s:comm

python << EOPY
if commentor_cpp not in vars():
    commentor_cpp = Commentor('//')
EOPY

nmap <Leader>' :py commentor_cpp.toggle_comment() <CR>
vmap <Leader>' :py commentor_cpp.toggle_comment() <CR>
