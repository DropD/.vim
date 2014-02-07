if !has('python')
    echo "Error: Requires vim compiled with +python"
    finish
endif

function! CreateCommands()

" start python code
python << EOPY
import vim, ast, codegen

sss = 'call ScreenShellSend("{0}")'

def prepare_and_send():
    cb = vim.current.buffer

    py_file_orig = '\n'.join([i for i in cb])
    py_file_prep = '%cpaste\n' + py_file_orig + '\n--\n'

    vim.command(sss.format(py_file_prep))

def extract_and_send():
    cb = vim.current.buffer

    py_file_orig = '\n'.join([i for i in cb])
    py_file_ast = ast.parse(py_file_orig)

    isfun = lambda node : type(node) == ast.FunctionDef
    iscl  = lambda node : type(node) == ast.ClassDef

    py_fun_class_ast = [node for node in ast.iter_child_nodes(py_file_ast) if isfun(node) or iscl(node)]
    py_fun_class_string = '\n'.join([codegen.to_source(node) for node in py_fun_class_ast])

    py_file_prep = '%cpaste\n' + py_fun_class_string + '\n--\n'

    vim.command(sss.format(py_file_prep))

def send_current():
    cb = vim.current.buffer

    vim.command("let RICOH_LN = line('.')")
    lnum = vim.vars['RICOH_LN']

    py_file_orig = '\n'.join([i for i in cb])
    py_file_ast = ast.parse(py_file_orig)

    isbcur = lambda node : node.lineno <= lnum

    py_curr_ast = [node for node in ast.iter_child_nodes(py_file_ast) if isbcur(node)][-1]
    py_curr_string = codegen.to_source(py_curr_ast)

    py_file_prep = '%cpaste\n' + py_curr_string + '\n--\n'

    vim.command(sss.format(py_file_prep))

def send_line():
    cb = vim.current.buffer
    vim.command(sss.format(cb[0].strip()))
 
# end python code
EOPY

endfunction

call CreateCommands()

nmap <Leader>cs :py prepare_and_send()<CR>
nmap <Leader>cd :py extract_and_send()<CR>
nmap <Leader>cc :py send_current()<CR>
nmap <Leader>cl :py send_line()<CR>
