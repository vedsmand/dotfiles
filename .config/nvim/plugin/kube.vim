" plugin/kube.vim
if exists('g:loaded_kube') | finish | endif

let s:save_cpo = &cpo
set cpo&vim

hi def link KubeCtxHeader      Number
hi def link KubeDirHeader   Directory
hi def link KubeCmdHeader   ModeMsg

command! Kube lua require'kube'.kube()

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_kube = 1
