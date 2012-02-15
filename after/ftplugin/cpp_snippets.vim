if !exists('loaded_snippet') || &cp
    finish
endif

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

exec 'Snippet exhead /*<CR>Informatikgestützte Chemie I: Exercise'.st.et.'<CR>Rico Häuselmann<CR>ricoh@student.ethz.ch<CR>'.st.'date'.et.'<CR>/'
