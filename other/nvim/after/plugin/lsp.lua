local lsp = require('lsp-zero').preset({})

lsp.preset("recommended")

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-Space>'] = cmp.mapping.confirm({ select = true }) })

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})

vim.diagnostic.config({
	virtual_text = false,
})

-- this is local variable is used for modifying filetype on lsp
local servers = {
    clangd = {
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda'}
    },
}

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}
	local options = { reuse_win = true }
    lsp.default_keymaps({buffer = bufnr})
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition(options) end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "<leader>dn", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "<leader>dp", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

end)

-- if you want to modify installed lsp
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {'tsserver', 'clangd', 'gopls', 'lua_ls', 'pyright'},
    handlers = {
        lsp.default_setup,
        clangd = function()
            require('lspconfig').clangd.setup({
                filetypes = servers.clangd.filetypes
            })
        end,
    }
})

-- disable semantic highlights
lsp.set_server_config({
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})



-- lsp is not doing the vim.lsp.buffer.format() function call
lsp.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
})

lsp.setup()
