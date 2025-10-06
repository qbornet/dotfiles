-- modified lsp zero
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('user_lsp_attach', {clear = true}),
    callback = function(event)
        local opts = { buffer = event.buf }
        local options = { reuse_win = true }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition(options) end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>dn", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "<leader>dp", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    end
})

vim.diagnostic.config({
	virtual_text = false,
    update_in_insert = true,
})

-- this is local variable is used for modifying filetype on lsp
local servers = {
    clangd = {
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda'}
    },
}

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp_config = vim.lsp.config()

print(lsp_config)


-- lspconfig is required for clangd weird behavior with mason-lspconfig.
vim.lsp.config().clangd.setup({
    capabilities = lsp_capabilities,
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--clang-tidy-checks=-*,readability-identifier-naming",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
    },
    filetypes = servers.clangd.filestypes,
})

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'clangd' },
    automatic_enable = true,
    handlers = {
        function(server_name)
            vim.lsp.config()[server_name].setup({
                capabilities = lsp_capabilities,
            })
        end,
        lua_ls = function()
            vim.lsp.config().lua_ls.setup({
                capabilities = lsp_capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT'
                        },
                        diagnostics = {
                            globals = {'vim'},
                        },
                        workspace = {
                            library = {
                                vim.env.VIMRUNTIME,
                            }
                        }
                    }
                }
            })
        end
    }
})


local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
    }, {
        {name = 'buffer'},
    }),
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-space>'] = cmp.mapping.complete(),
        ['<Tab>'] = nil,
        ['<S-Tab>'] = nil,
    }),
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end
    },
})

local null_ls = require('null-ls')
local augroup = vim.api.nvim_create_augroup("LspFormating", {})
local clang_format_file = vim.fn.expand("~/.config/nvim/skeleton/.clang-format")

null_ls.setup({
    debug = false,
   on_attach = function(client, bufnr)
       if client.supports_method("textDocument/formatting") then
           vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
           vim.api.nvim_create_autocmd("BufWritePre", {
               group = augroup,
               buffer = bufnr,
               callback = function()
                   vim.lsp.buf.format({
                       bufnr = bufnr,
                       filter = function(client)
                           return client.name == "null-ls"
                       end
                   })
               end
           })
       end
   end,
   sources = {
       null_ls.builtins.formatting.clang_format.with({
           extra_args = {
               "--style=file:" .. clang_format_file,
           },
       }),
   }
})
