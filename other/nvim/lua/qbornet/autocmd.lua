-- for change indent to 2 instead of usual 4
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact", "json" },
    command = "setlocal sw=2 ts=2"
})

-- for change indent to 8 instead of usual 4
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "go" },
    command = "setlocal sw=8 ts=8"
})

-- visual change
vim.api.nvim_create_autocmd(
{ "InsertLeave" },
{ pattern = "*", command = "set nocursorline", group = cursorGrp}
)

vim.api.nvim_create_autocmd(
{ "InsertEnter" },
{ pattern = "*", command = "set cursorline", group = cursorGrp}
)

-- ctags
vim.api.nvim_create_autocmd(
{ "BufWritePost" },
{ pattern = { "*.c", "*.h", "*.cpp", "*.hpp" }, command = "silent! !ctags . &" }
)

-- colorized ansi


vim.api.nvim_create_autocmd(
{ "BufWinEnter" },
{
    pattern =  {"*.log"},
    callback = function()
        local localBaleia = require('baleia').setup({})
        localBaleia.once(vim.api.nvim_get_current_buf())
        localBaleia.automatically(vim.api.nvim_get_current_buf())
end
}
)
