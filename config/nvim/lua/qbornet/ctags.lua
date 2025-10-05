vim.api.nvim_create_autocmd(
{ "BufWritePost" },
{ pattern = { "*.c", "*.h", "*.cpp", "*.hpp" }, command = "silent! !ctags . &" }
)
