local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { noremap = true})
if vim.fn.executable('rg') > 0 then
    vim.keymap.set('n', '<leader>ps', builtin.live_grep, { noremap = true })
else
    vim.keymap.set('n', '<leader>ps', function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") });
    end, { noremap = true })
end
