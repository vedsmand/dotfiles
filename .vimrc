call plug#begin('~/.vim/plugged')
"
Plug 'VundleVim/Vundle.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'terryma/vim-smooth-scroll'
Plug 'morhetz/gruvbox'
"Plug 'preservim/nerdtree'
Plug 'hashivim/vim-terraform'
Plug 'vimwiki/vimwiki'
Plug 'jiangmiao/auto-pairs'
Plug 'justinmk/vim-dirvish'
"
call plug#end()
"
filetype plugin indent on " Vundle requirement
"""""" VUNDLE  END"""""""""""""""""""""""""
"
let g:airline_theme='biogoo'
let g:airline#extensions#tabline#enabled = 1
let g:airline#enable#fugitive=1
"
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
"
set directory=~/.vimswp
set undodir=~/.vim_undo
set undofile              " Maintain undo history between sessions.
set autoread              " autoread file changes on git branch checkouts
"
"" Per default, netrw leaves unmodified buffers open. This deletes netrw's
"" buffer once it's hidden
autocmd FileType netrw setl bufhidden=delete  " or use :qa!
"
syntax on                 " Enable syntax highlighting.
set hidden
set noerrorbells
set smartindent
set nu
set smartcase
set noswapfile
set nobackup
set incsearch
set autoindent            " Respect indentation when starting a new line.
set expandtab             " Expand tabs to spaces. Essential in Python.
set shiftwidth=2          " Number of spaces to use for autoindent.
set backspace=2           " Fix backspace behavior on most terminals.
set tabstop=2             " number of visual spaces per TAB
set softtabstop=2         " number of spaces in tab when editing
set number                " show line numbers
set relativenumber        " show relative line numbers
set showcmd               " show command in bottom bar
set background=dark
colorscheme gruvbox
set cursorline            " highlight current line
set showmatch             " highlight matching [{()}]
set wildmenu              " Display command line's tab complete options as a menu.
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey
set noshowmode
let mapleader = " "

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

nnoremap <c-h> :bprevious<CR>
nnoremap <c-l> :bnext<CR>
map <c-n> :NERDTreeToggle<CR>

" Quickly insert an empty new line without entering insert mode
nnoremap <Leader><CR> o<Esc>

nnoremap <Leader>b :bufdo bd<CR>
nnoremap <Leader>gg :Git <CR>
nnoremap <Leader>g :Git 
nnoremap <Leader>c :Git commit -am ""<Left>

nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>
nnoremap ; :

"---------------------------------------
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

"---------------------------------------
"coc.nvim
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
