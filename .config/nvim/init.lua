--------------------------------------------
--
--this config is working for nvim version:
--
--  NVIM v0.8.0-1210-gd367ed9b2
--  Build type: RelWithDebInfo
--  LuaJIT 2.1.0-beta3
--
--------------------------------------------


local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/nvim/vim-plug')

Plug 'nvim-lualine/lualine.nvim'
Plug 'terryma/vim-smooth-scroll'
Plug 'morhetz/gruvbox'
Plug 'justinmk/vim-dirvish'
Plug 'numToStr/FTerm.nvim'
Plug 'hashivim/vim-terraform' -- for hcl highlight
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})  -- We recommend updating the parsers on update
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'ANGkeith/telescope-terraform-doc.nvim'
Plug 'iamcco/markdown-preview.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'rafamadriz/friendly-snippets'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'beauwilliams/focus.nvim'
Plug'akinsho/bufferline.nvim'
Plug 'Yggdroot/indentLine'
Plug 'dense-analysis/ale'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

vim.call('plug#end')

vim.cmd([[

filetype plugin indent on " 
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
"set wildmenu              Display command line's tab complete options as a menu.
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey
set noshowmode
let mapleader = " "
set splitbelow
set splitright
set completeopt=menu,menuone,noselect "needed for nvim-cmp

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab " yaml indentation

"" ale yamllint "" https://www.arthurkoziel.com/setting-up-vim-for-yaml/
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'

"" ale yamllint ""

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
nnoremap <leader>ott :Telescope terraform_doc<cr>
nnoremap <leader>otm :Telescope terraform_doc modules<cr>

command Exec set splitright | vnew | set filetype=sh | read !sh #
]])

require('gitsigns').setup()
require("focus").setup()
require("luasnip")
require('lualine').setup {
  options = { theme  = 'gruvbox' },
}
require("snippets")
require("completion")
require("luasnip/loaders/from_vscode").lazy_load()
require("fterm")
require("lspconf")
require("treesitter")
require("bufferline").setup{}
require("terraform")
require('telescope').load_extension('terraform_doc')

--
-- https://github.com/axkirillov/easypick.nvim
