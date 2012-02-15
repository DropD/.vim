if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufNewFile,BufRead *.ly           setf lilypond
augroup END

augroup filetypedetect
  au! BufRead,BufNewFile *.sage,*.spyx,*.pyx setfiletype python
augroup END

augroup filetypedetect
  au! BufNewFile,BufRead *.cl setf opencl
augroup END
