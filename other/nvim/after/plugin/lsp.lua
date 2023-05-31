
local lsp = require('lsp-zero').preset({})

lsp.preset("recommended")

lsp.ensure_installed({
	'tsserver',
	'clangd',
	'lua_ls',
	'pyre'
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-Space>'] = cmp.mapping.confirm({ select = true })
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})

vim.diagnostic.config({
	virtual_text = false,
})

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}
	local options = { reuse_win = true }
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition(options) end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "<leader>dn", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "<leader>dp", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

end)

lsp.setup()
