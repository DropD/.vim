:Snippet ser Serial.begin(<{460800}>);
:Snippet f <{void}> <{f}>(<{}>) {<CR><{}><CR>}
:Snippet class <{class}> <{parent}><CR>{<CR><{}><CR>};
:Snippet temp template <<{}>><CR><{}>
:Snippet for for (<{int}> <{i}> = <{0}>; <{i}> < <{N}>; ++<{i}>) <{}>
:Snippet td typedef <{}> <{}>;
:Snippet tn typename
:Snippet std std::
:Snippet cout std::cout
:Snippet endl std::endl
:Snippet vector std::vector<<{}>><{}>
:Snippet main int main(int argc, char const *argv[])<CR>{<CR><{}><CR><CR>}

function! Headername()
    return substitute(substitute(expand("%"), '\.', '_', 'g'), '.', '\u&', 'g')
endfunction
:Snippet hg #ifndef ``Headername()``<CR>#define ``Headername()``<CR><CR><{}><CR><CR>#endif
