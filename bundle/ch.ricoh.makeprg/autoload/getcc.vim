if !has('python')
    echo "Error: Requires vim compiled with +python"
    finish
endif

function! getcc#Getbuildsys()

" start python code
python << EOF
import vim, os, re

cb = vim.current.buffer
path, name = os.path.split(cb.name)

buildfiles = {'cmake' : 'CMakeLists.txt',
              'make'  : 'Makefile'}

def hassysfile(path):
    ls = os.listdir(path)
    if 'CMakeLists.txt' in ls:
        return 'cmake'
    elif 'Makefile' in ls:
        return 'make'
    else:
        return None

def getsysandroot(path):
    bsys = hassysfile(path)
    vim.command('echo "found {}, looking for root."'.format(bsys))
    startpath = path
    bflist = []
    if bsys:
        bflist.insert(0, os.path.join(path, buildfiles[bsys]))
        up, cur = os.path.split(path)
        while bsys == hassysfile(up):
            path = up
            bflist.insert(0, os.path.join(path, buildfiles[bsys]))
            up, cur = os.path.split(path)
    vim.command('echo "found root at {}."'.format(path))
    vim.command('echo "all in all we have the following build files: {}"'.format(bflist))
    return bsys, path, startpath, bflist

specialfolders = ['/src', '/include', '/lib']
if not hassysfile(path):
    sfocc = [path.find(i) for i in specialfolders]
    firstsf = min([i for i in sfocc if i > 0])
    if firstsf > 0:
        path = path[:firstsf]
vim.command('echo "searching for buildsys in {}."'.format(path))
bsys, root, leaf, bflist = getsysandroot(path)

vim.command('let b:ricohBuildLeaf="{}"'.format(leaf))
vim.command('let b:ricohBuildRoot="{}"'.format(root))
vim.command('let b:ricohBuildSys="{}"'.format(bsys))
vim.command('let b:ricohBuildFiles={}'.format(bflist))
vim.command('let s:output="[{}, {}]"'.format(root, bsys))

#end python code
EOF

return s:output

endfunction
