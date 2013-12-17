if !has('python')
    echo "Error: Requires vim compiled with +python"
    finish
endif

python << EOF
def all_comment(s, st, en, cstr = '#~ '):
    for i in range(st, en):
        if cstr not in s[i]:
            return False
    return True

def toggle_comment():
    import vim, re
    cstr = '#~ '

    r = vim.current.range
    rlen = r.end - r.start + 1
    ac = all_comment(r, 0, rlen)
    for i in range(0, rlen):
        r[i] = r[i].replace(cstr, '')
    if not ac:
        for i in range(0, rlen):
            r[i] = re.sub(r'^(\s+)', r'\1#~ ', r[i])

EOF

nmap <Leader>' :py toggle_comment() <CR>
vmap <Leader>' :py toggle_comment() <CR>
