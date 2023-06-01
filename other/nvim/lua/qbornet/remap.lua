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
