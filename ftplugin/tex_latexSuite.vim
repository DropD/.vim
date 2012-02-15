" LaTeX filetype
"	  Language: LaTeX (ft=tex)
"	Maintainer: Srinath Avadhanula
"		 Email: srinath@fastmail.fm

if !exists('s:initLatexSuite')
	let s:initLatexSuite = 1
	exec 'so '.fnameescape(expand('<sfile>:p:h').'/latex-suite/main.vim')

	silent! do LatexSuite User LatexSuiteInitPost
endif

silent! do LatexSuite User LatexSuiteFileType

let g:Tex_DefaultTargetFormat ='pdf'

let g:Tex_CompileRule_dvi       = 'latex --interaction=nonstopmode $*'
let g:Tex_CompileRule_ps        = 'dvips -Pwww -o $*.ps $*.dvi'
let g:Tex_CompileRule_pspdf     = 'ps2pdf $*.ps'
let g:Tex_CompileRule_dvipdf    = 'dvipdfm $*.dvi'
let g:Tex_CompileRule_pdf       = 'pdflatex -synctex=1 --interaction=nonstopmode $*'

let g:Tex_ViewRule_dvi  = 'texniscope'
let g:Tex_ViewRule_ps   = 'Preview'
let g:Tex_ViewRule_pdf  = 'Skim'

let g:Tex_FormateDependency_ps      = 'dvi,ps'
let g:Tex_FormateDependency_pspdf   = 'dvi,ps,pspdf'
let g:Tex_FormateDependency_dvipdf  = 'dvi,dvipdf'

" let g:Tex_IgnoredWarnings ='
"       \"Underfull\n".
"       \"Overfull\n".
"       \"specifier changed to\n".
"       \"You have requested\n".
"       \"Missing number, treated as zero.\n".
"       \"There were undefined references\n".
"       \"Citation %.%# undefined\n".
"       \"\oval, \circle, or \line size unavailable\n"'

