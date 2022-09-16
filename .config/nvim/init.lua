local Plug = vim.fn['plug#']
local map  = vim.api.nvim_set_keymap 

vim.call('plug#begin', '~/nvim/vim-plug')

Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jamestthompson3/nvim-remote-containers'
Plug 'terryma/vim-smooth-scroll'
Plug 'morhetz/gruvbox'
Plug 'hashivim/vim-terraform'
Plug 'justinmk/vim-dirvish'
Plug 'phaazon/hop.nvim'
Plug 'numToStr/FTerm.nvim'
-- telescope --
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})  -- We recommend updating the parsers on update
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
-- telescop --
Plug 'Chiel92/vim-autoformat' -- python3 autoformat
Plug 'iamcco/markdown-preview.nvim'

vim.call('plug#end')

vim.cmd([[

filetype plugin indent on " 
"
let g:airline_theme='biogoo'
let g:airline#extensions#tabline#enabled = 1
"
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
"
set directory=~/.vimswp
set undodir=~/.vim_undo
set undofile              " Maintain undo history between sessions.
set autoread              " autoread file changes on git branch checkouts
"
syntax on                 " Enable syntax highlighting.
set hidden
set noerrorbells
set smartindent
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
set splitbelow
set splitright

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

nnoremap <c-h> :bprevious<CR>
nnoremap <c-l> :bnext<CR>

nnoremap ; :
" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>gc <cmd>Telescope git_commits<cr>
nnoremap <leader>gb <cmd>Telescope git_branches<cr>
nnoremap <leader>gs <cmd>Telescope git_status<cr>

command Exec set splitright | vnew | set filetype=sh | read !sh #

]])

-- hop
require'hop'.setup()
map('n', '<leader>ww', "<cmd>lua require'hop'.hint_words()<cr>", {})
map('n', '<leader>ll', "<cmd>lua require'hop'.hint_lines()<cr>", {})
--hop


-- FTerm
require'FTerm'.setup({
  cmd = 'zsh'
})
local FTerm_opts = { noremap = true, silent = true }
map('n', '<leader>tt', '<CMD>lua require("FTerm").toggle()<CR>', FTerm_opts)
map('t', '<leader>tt', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', FTerm_opts)
-- FTerm

