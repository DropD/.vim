import vim, re

print 'bla'

class Commentor(object):
    def __init__(self, cstr):
        self._cstr = cstr + '~'

    def all_comment(self, s, st, en):
        for i in range(st, en):
            if self._cstr not in s[i]:
                return False
        return True

    def toggle_comment(self):
        r = vim.current.range
        rlen = r.end - r.start + 1
        ac = self.all_comment(r, 0, rlen)
        for i in range(0, rlen):
            r[i] = r[i].replace(self._cstr, '')
        if not ac:
            for i in range(0, rlen):
                r[i] = re.sub(r'^(\s+)', r'\1{0} '.format(self._cstr), r[i])
