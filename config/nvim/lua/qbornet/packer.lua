local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

-- This file can be loaded by calling `lua require('plugins')` from your init.vim

local packer_bootstrap = ensure_packer()
Handle = io.popen("lsb_release -a 2> /dev/null | cut -d ':' -f2 | tr -d '\t' | grep ^Ubuntu$ | tr -d '\n'")
Distro = Handle:read("*a")

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

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
            "rose-pine/neovim",
            as = "rose-pine",
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
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }
    use { "folke/neodev.nvim", opts = {} }
    use 'ray-x/go.nvim'
    use 'gpanders/nvim-parinfer'
    use { 'm00qek/baleia.nvim', tag = 'v1.4.0' }
    use 'motosir/skel-nvim' -- check the github page for substitution on skeleton
    use {
        'nvimtools/none-ls.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
	if packer_bootstrap then
		require('packer').sync()
	end
end)
