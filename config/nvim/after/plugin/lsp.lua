-- Modified LSP configuration for Neovim 0.11+
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

        if vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(false, { bufnr = event.buf })
        end
    end
})

vim.diagnostic.config({
    virtual_text = false,
    update_in_insert = true,
})

-- Get capabilities from nvim-cmp
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Setup Mason 
require('mason').setup({})

-- Table for custom server configurations
local server_configs = {
    clangd = {
        cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--clang-tidy-checks=-*,readability-identifier-naming",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
                "--query-driver=/nix/store/**/bin/gcc,/nix/store/**/bin/clang",
        },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
        root_markers = {'.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', '.git'},
        on_new_config = function(config, root_dir)
            -- Auto-generate compile_flags.txt if it doesn't exist
            local compile_flags_path = root_dir .. "/compile_flags.txt"

            if vim.fn.filereadable(compile_flags_path) == 0 then
                local glibc_path = vim.fn.system("nix-build '<nixpkgs>' -A glibc.dev --no-out-link 2>/dev/null"):gsub("%s+", "")

                if vim.fn.isdirectory(glibc_path) == 1 then
                    local flags = {
                        "-xc",
                        "-isystem" .. glibc_path .. "/include",
                    }

                    -- Write compile_flags.txt
                    local file = io.open(compile_flags_path, "w")
                    if file then
                        for _, flag in ipairs(flags) do
                            file:write(flag .. "\n")
                        end
                        file:close()
                        print("Generated " .. compile_flags_path .. " with default include paths")
                    end
                end
            end
        end,
    },
    lua_ls = {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', '.git' },
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT'
                },
                diagnostics = {
                    globals = {'vim'},
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                        "${3rd}/luv/library",
                    }
                }
            }
        }
    },
    zls = {
        cmd = { 'zls' },
        filetypes = { 'zig', 'zir' },
        root_markers = { 'zls.json', 'build.zig', '.git' },
    },
}

-- Function to setup an LSP server
local function setup_server(server_name)
    -- Get custom config or use empty table
    local config = server_configs[server_name] or {}
    
    -- Always add capabilities
    config.capabilities = lsp_capabilities
    
    -- Register the server config
    vim.lsp.config(server_name, config)
end

-- Get list of installed servers from mason-lspconfig
local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup({
    ensure_installed = { 'lua_ls', 'clangd', 'zls' },
})

-- Get all available servers (Mason-installed + manually specified)
local available_servers = mason_lspconfig.get_installed_servers()

-- Setup all servers
for _, server_name in ipairs(available_servers) do
    setup_server(server_name)
end

-- Build a filetype to servers mapping
local filetype_to_servers = {}
for _, server_name in ipairs(available_servers) do
    local config = server_configs[server_name]
    local filetypes = config and config.filetypes or {}
    for _, ft in ipairs(filetypes) do
        if not filetype_to_servers[ft] then
            filetype_to_servers[ft] = {}
        end
        table.insert(filetype_to_servers[ft], server_name)
    end
end

-- Create autocmd to start LSP servers when appropriate filetypes are opened
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('LspStart', { clear = true }),
    callback = function(args)
        local filetype = vim.bo[args.buf].filetype
        local servers = filetype_to_servers[filetype]
        if servers then
            for _, server_name in ipairs(servers) do
                vim.lsp.enable(server_name)
            end
        end
    end,
})

-- nvim-cmp setup
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

-- none-ls setup for formatting
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
