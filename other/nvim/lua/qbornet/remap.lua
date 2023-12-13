-- qol map
vim.g.mapleader = " "

vim.keymap.set("n", "gb", "``", { noremap = true }) -- nnoremap gb ``
vim.keymap.set("n", "ts", vim.cmd.nohlsearch, { noremap = true }) -- nnoremap ts nohlsearch
vim.keymap.set("i", "jk", "<Esc>", { noremap = true }) -- inoremap jk <Esc>
vim.keymap.set("n", "<leader>l", vim.cmd.buffers, { noremap = true }) --nnoremap <leader>l :buffers <CR>
vim.keymap.set("i", "{<CR>", "{<CR>}<C-o>O", { noremap = true }) -- inoremap {<CR> {<CR>}<C-o>O

-- MaximizeWindow remove keymap that could use :only
vim.keymap.set("n", "t3", ":lua MaximizeToggle()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-W>O", ":lua MaximizeToggle()<CR>", { noremap = true , silent = true })
vim.keymap.set("n", "<C-W>o", ":lua MaximizeToggle()<CR>", { noremap = true , silent = true })
vim.keymap.set("n", "<C-W><C-O>", ":lua MaximizeToggle()<CR>", { noremap = true , silent = true })


-- qol map

-- terminal map

-- exit terminal mode
vim.keymap.set("t", "jk", "<C-\\><C-n>", { noremap = true }) -- tnoremap jk <C-\><C-n>

-- open terminal in split pane
vim.keymap.set("n", "<C-w>t", ":sp +term <CR>i") -- nmap <C-w>t :term <CR>

-- terminal map

-- ctags

vim.keymap.set("n", "tn", ":tnext <CR>", { noremap = true, silent = true })
vim.keymap.set("n", "tn", ":tprev <CR>", { noremap = true, silent = true })

-- ctags

-- oil

vim.keymap.set("n", "<leader>f", require("oil").open, { desc = "Open parent directory" })

-- oil


-- dapui

vim.keymap.set("n", "<leader>o", require('dapui').open, { desc = "Open dapui"})
vim.keymap.set("n", "<leader>q", require('dapui').close, { desc = "Close dapui"})
vim.keymap.set("n", "<leader>tg", require('dapui').toggle, { noremap = true, desc = "Toggle dapui"})
vim.keymap.set("n", "<leader>i", require('dapui').float_element, { noremap = true, desc = "Inspect element dapui"})
vim.keymap.set("v", "<leader>e", require('dapui').eval, { noremap = true, desc = "Eval expression dapui"})

-- dapui

-- dap

vim.keymap.set("n", "<leader>t", require('dap-go').debug_test, { silent = true, noremap = true,  desc = "Debug test" })
vim.keymap.set("n", "<leader>c", require('dap').continue, { desc = "Start debug"})
vim.keymap.set("n", "<leader>b", require('dap').toggle_breakpoint, { desc = "Create or remove breakpoint to cursor position"})
vim.keymap.set('n', '<Leader>B', require('dap').set_breakpoint, { desc = "Overwrite breakpoint to cursor position"})
vim.keymap.set("n", "<leader>s", require('dap').step_into, { desc = "Step into a function"})
vim.keymap.set("n", "<leader>S", require('dap').step_out, { desc = "Step out of a function"})
vim.keymap.set("n", "<leader>n", require('dap').step_over, { desc = "Next line"})
--vim.keymap.set("n", "<F5>", ":lua require'dap'.disconnect({ terminateDebugee = true})<CR> | :lua require'dap'.close()<CR>", { silent = true, desc = "Close debuging session"})

-- dap
