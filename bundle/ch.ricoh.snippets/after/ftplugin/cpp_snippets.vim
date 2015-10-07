:Snippet ser Serial.begin(<{460800}>);
:Snippet f <{void}> <{f}>(<{}>) <{}> {<CR><{}><CR>}
:Snippet class class <{name}> <{parent}> {<CR><{}><CR>};
:Snippet temp template <<{}>><CR><{}>
:Snippet for for (<{int}> <{i}> = <{0}>; <{i}> < <{N}>; ++<{i}>) <{}>
:Snippet td typedef <{}> <{}>;
:Snippet tn typename <{}>
:Snippet std std::<{}>
:Snippet cout std::cout << <{}>;
:Snippet endl std::endl<{}>
:Snippet vector std::vector<<{}>><{}>
:Snippet main int main(int argc, char const *argv[])<CR>{<CR><{}><CR>}

function! Headername()
    if b:ricohBuildLeaf && (b:ricohBuildLeaf != expand("%:p:h:t")) && (expand("%:p:h:t") != "include")
        return substitute(expand("%:p:h:t") . "/". expand("%:t:r") . "_" . expand("%:e"), '.', '\u&', 'g')
    else
        return substitute(substitute(expand("%:t"), '\.', '_', 'g'), '.', '\u&', 'g')
    endif
endfunction
:Snippet hg #ifndef ``Headername()``<CR>#define ``Headername()``<CR><CR><{}><CR><CR>#endif

:Snippet using using <{alias}> = <{type}>;
:Snippet ns namespace <{namespace}> {<CR><{}><CR>};
:Snippet lambda [<{}>](<{}>){<{}>}<{}>
:Snippet in' #include "<{header}>"<{}>
:Snippet in< #include <<{header}>><{}>
