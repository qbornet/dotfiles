-- Modern Filetype Mapping
-- Instead of a clunky autocommand, use the native filetype API to treat .zsh as .sh
vim.filetype.add({
    extension = {
        zsh = "sh",
    },
})

-- Core Tree-sitter Highlighting
-- Since 'highlight = { enable = true }' is deprecated in the plugin setup,
-- this universal autocmd automatically starts Tree-sitter for any supported filetype.
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
        if lang then
            pcall(vim.treesitter.start)
        end
    end,
})

-- Stripped-down Plugin Configuration
local has_ts, ts = pcall(require, "nvim-treesitter")
if has_ts then
    -- The new setup function takes no heavy module configurations
    ts.setup({})

    -- Programmatic alternative to 'ensure_installed' for unbundled parsers
    -- (javascript, typescript, and go aren't bundled by default in 0.12)
    local extra_parsers = { "javascript", "typescript", "go", "c", "cpp", "zig"}
    
    local ts_config = pcall(require, "nvim-treesitter.config")
    local installed = ts_config and require("nvim-treesitter.config").get_installed() or {}

    local to_install = {}
    for _, lang in ipairs(extra_parsers) do
        if not vim.tbl_contains(installed, lang) then
            table.insert(to_install, lang)
        end
    end

    if #to_install > 0 then
        -- Directly invokes the new install API
        pcall(ts.install, to_install)
    end
end
