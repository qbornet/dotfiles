require('onedark').load()

vim.cmd([[autocmd TermOpen * setlocal nonumber norelativenumber]])

vim.api.nvim_create_autocmd(
{ "InsertLeave" },
{ pattern = "*", command = "set nocursorline", group = cursorGrp}
)

vim.api.nvim_create_autocmd(
{ "InsertEnter" },
{ pattern = "*", command = "set cursorline", group = cursorGrp}
)

-- Maximized the current pane and if on a current pane that is maximized 
-- go back to regular size

function MaximizeToggle()
  local winid = vim.api.nvim_get_current_win()

  if not _G.s or not _G.s.maximized_winid then
    -- Maximize the current split pane
    _G.s = {
      maximized_winid = winid,
      original_layout = vim.fn.winrestcmd()
    }

    -- Set the current split pane to full size
    vim.api.nvim_win_set_width(winid, vim.o.columns)
    vim.api.nvim_win_set_height(winid, vim.o.lines)
  else
    if _G.s.maximized_winid == winid then
      -- Restore all split panes to their original sizes
      vim.api.nvim_command(_G.s.original_layout)
      _G.s = {}
    else
      -- Restore the previously maximized split pane
      vim.api.nvim_command(_G.s.original_layout)

      -- Maximize the current split pane
      _G.s.maximized_winid = winid
      _G.s.original_layout = vim.fn.winrestcmd()

      -- Set the current split pane to full size
      vim.api.nvim_win_set_width(winid, vim.o.columns)
      vim.api.nvim_win_set_height(winid, vim.o.lines)
    end
  end
end
