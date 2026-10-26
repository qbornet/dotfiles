-- Filetype detection
vim.filetype.add({
    extension = {
        zsh = "sh",
        ziggy = "ziggy",
        ["ziggy-schema"] = "ziggy_schema",
    },
})

-- Tree-sitter highlighting
vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local lang = vim.treesitter.language.get_lang(
            vim.bo[args.buf].filetype
        )

        if lang then
            pcall(vim.treesitter.start, args.buf, lang)
        end
    end,
})

-- Tree-sitter configuration
local ok, ts = pcall(require, "nvim-treesitter")

if ok then
    ts.setup({})

    local extra_parsers = {
        "javascript",
        "typescript",
        "go",
        "c",
        "cpp",
        "zig",
        "ziggy",
        "ziggy_schema",
    }

    -- Install missing parsers
    local config = require("nvim-treesitter.config")
    local installed = config.get_installed()

    local to_install = {}

    for _, lang in ipairs(extra_parsers) do
        if not vim.tbl_contains(installed, lang) then
            table.insert(to_install, lang)
        end
    end

    if #to_install > 0 then
        ts.install(to_install)
    end
end

