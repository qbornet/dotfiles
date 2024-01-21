-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
Handle = io.popen("lsb_release -a 2> /dev/null | cut -d ':' -f2 | tr -d '\t' | grep ^Ubuntu$ | tr -d '\n'")
Distro = Handle:read("*a")

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

    if Distro == "Ubuntu" then

        use {
            'navarasu/onedark.nvim',
            run = function()
                pcall(vim.cmd, 'PackerSync')
            end,
        }

    else

        use {
            "catppuccin/nvim",
            as = "catppuccin",
            run = function()
                pcall(vim.cmd, 'PackerSync')
            end,
        }

    end

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	}

	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{                                      -- Optional
				'williamboman/mason.nvim',
				run = function()
					pcall(vim.cmd, 'MasonUpdate')
				end,
			},
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},     -- Required
			{'hrsh7th/cmp-nvim-lsp'}, -- Required
			{'L3MON4D3/LuaSnip'},     -- Required
		}
	}

    use 'nvim-tree/nvim-web-devicons'
    use {
        'stevearc/oil.nvim',
        config = function() require('oil').setup() end
    }

    use 'mfussenegger/nvim-dap'
    use 'leoluz/nvim-dap-go'
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
    use { "folke/neodev.nvim", opts = {} }
end)
