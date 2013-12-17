if !has('python')
    echo "Error: Requires vime compiled with +python"
    finish
endif

let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let s:comm = s:path.'/commentor.py'

execute "pyfile ".s:comm

python << EOPY
ricoh_comm = Commentor('//')
EOPY

nmap <Leader>' :py ricoh_comm.toggle_comment() <CR>
vmap <Leader>' :py ricoh_comm.toggle_comment() <CR>
