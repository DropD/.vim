if !has('python')
    echo "Error: Requires vim compiled with +python"
    finish
endif

function! CreateCommands()

" start python code
python << EOPY
import vim, ast, time, re
from astor import codegen

sss = 'call ScreenShellSend("{0}")'

def get_ast():
    f = vim.current.buffer.name
    with open(f) as code_file:
        code_string = code_file.read()
    return ast.parse(code_string)

def paste_to_ipy(code):
    vim.command(sss.format('%cpaste\n'))
    time.sleep(0.01)
    mls = False
    for line in [i for i in code.split('\n') if i]:
        #if line.strip()[0] == "'" and "\\n" in line:
        #    line = "\'\'"+line+"\'\'"
        line = re.sub(r"('.*\\n.*')", r"\'\'\1\'\'", line)
        vim.command(sss.format(line+'\n'))
    vim.command(sss.format('\n--\n'))


def prepare_and_send():
    cb = vim.current.buffer

    py_file_orig = '\n'.join([i for i in cb])
    # py_file_prep = '%cpaste\n' + py_file_orig + '\n--\n'

    # vim.command(sss.format(py_file_prep))
    paste_to_ipy(py_file_orig)

def extract_and_send():
    # cb = vim.current.buffer

    # py_file_orig = '\n'.join([i for i in cb])
    #py_file_ast = ast.parse(py_file_orig)
    py_file_ast = get_ast()

    isfun = lambda node : type(node) == ast.FunctionDef
    iscl  = lambda node : type(node) == ast.ClassDef

    py_fun_class_ast = [node for node in ast.iter_child_nodes(py_file_ast) if isfun(node) or iscl(node)]
    #py_fun_class_string = '\n'.join([codegen.to_source(node) for node in py_fun_class_ast])

    #py_file_prep = '%cpaste\n' + py_fun_class_string + '\n--\n'

    #vim.command(sss.format(py_file_prep))
    #paste_to_ipy(py_fun_class_string)
    for node in py_fun_class_ast:
        paste_to_ipy(codegen.to_source(node))
                                   
def send_current_top():
    # cb = vim.current.buffer

    vim.command("let RICOH_LN = line('.')")
    lnum = vim.vars['RICOH_LN']

    # py_file_orig = '\n'.join([i for i in cb])
    # py_file_ast = ast.parse(py_file_orig)
    py_file_ast = get_ast()

    isbcur = lambda node : node.lineno <= lnum

    py_curr_ast = [node for node in ast.iter_child_nodes(py_file_ast) if isbcur(node)][-1]
    py_curr_string = codegen.to_source(py_curr_ast)

    #py_file_prep = '%cpaste\n' + py_curr_string + '\n--\n'

    #vim.command(sss.format(py_file_prep))
    paste_to_ipy(py_curr_string)
 
def send_current_bottom():
    # cb = vim.current.buffer

    vim.command("let RICOH_LN = line('.')")
    lnum = vim.vars['RICOH_LN']

    # py_file_orig = '\n'.join([i for i in cb])
    # py_file_ast = ast.parse(py_file_orig)
    py_file_ast = get_ast()

    isbcur = lambda node : node.__dict__.has_key('lineno') and node.lineno <= lnum

    curnode = py_file_ast
    while(curnode.__dict__.has_key('body')):
        prevnode = curnode
        curnode = [node for node in ast.iter_child_nodes(curnode) if isbcur(node)][-1]

    py_curr_string = codegen.to_source(prevnode)

    #py_file_prep = '%cpaste\n' + py_curr_string + '\n--\n'

    #vim.command(sss.format(py_file_prep))
    paste_to_ipy(py_curr_string)

def send_line():
    cb = vim.current.range
    vim.command(sss.format(cb[0].strip()))

def send_file():
    cb = vim.current.buffer
    vim.command(sss.format('%load {0}'.format(cb.name)))
 
# end python code
EOPY

endfunction

call CreateCommands()

nmap <Leader>cs :py prepare_and_send()<CR>
nmap <Leader>cd :py extract_and_send()<CR>
nmap <Leader>cc :py send_current_top()<CR>
nmap <Leader>cb :py send_current_bottom()<CR>
nmap <Leader>cl :py send_line()<CR>
nmap <Leader>cf :py send_file()<CR>
