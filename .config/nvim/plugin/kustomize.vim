" inspired by https://learnvimscriptthehardway.stevelosh.com/chapters/52.html
"
if !exists("g:kustomize_command")
    let g:kustomize_command = "kustomize"
endif

function! KustomizeBuildFromFile()
    silent !clear
    " get the rendered yamls
    let yaml = system(g:kustomize_command . " " . "build" . " " . expand("%:h:p"))

    " Open a new vsplit and set it up
    vsplit Ks_Preview__
    normal! ggdG
    setlocal filetype=yaml
    setlocal buftype=nofile

    " insert the rendered yaml
    call append(0, split(yaml, '\v\n'))

endfunction

nnoremap <leader>kk :call KustomizeBuildFromFile()<cr>
