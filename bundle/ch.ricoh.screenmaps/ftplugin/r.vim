if !has('python')
    echo "Error: Requires vim compiled with +python"
    finish
endif

python << EOPY
import subprocess as sp
from shlex import split as shplit
from time import sleep
import os
from multiprocessing import Process

def tmux_set_cwd():
    sp.call(shplit('tmux set-option default-path .'))

def tmux_last_pane():
    sp.call(shplit('tmux last-pane'))

def tmux_set_vertical():
    sleep(1)
    sp.call(shplit('tmux select-layout even-horizontal'))

def async_set_vertical():
    p = Process(target=tmux_set_vertical)
    return p
EOPY

nmap <Leader>rF :py tmux_set_cwd(); async_set_vertical().start() <CR> <Leader>rf
