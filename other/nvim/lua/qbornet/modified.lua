vim.g.terminal_emulator="zsh"
vim.api.nvim_set_var('terminal_emulator', 'zsh')

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.clipboard = "unnamedplus"

if vim.fn.has('wsl') == 1 then

vim.api.nvim_create_autocmd('TextYankPost', {

group = vim.api.nvim_create_augroup('Yank', { clear = true }),

callback = function()

vim.fn.system('clip.exe', vim.fn.getreg('"'))

end,

})

end
