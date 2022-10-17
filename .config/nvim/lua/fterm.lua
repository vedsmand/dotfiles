local map  = vim.api.nvim_set_keymap 
local FTerm_opts = { noremap = true, silent = true }

require'FTerm'.setup({
  cmd = 'zsh'
})
map('n', '<leader>tt', '<CMD>lua require("FTerm").toggle()<CR>', FTerm_opts)
map('t', '<leader>tt', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', FTerm_opts)
