function ColorMyPencils(color)

    if Distro == "Ubuntu" then
        color = color or "onedark"
    else
        color = color or "catppuccin-macchiato"
    end

	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    Handle:close()
end

ColorMyPencils()
