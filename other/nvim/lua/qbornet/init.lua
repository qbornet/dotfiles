local path = vim.fn.glob("~/.local/share/nvim/site/pack/packer/start/packer.nvim")

if path == "" then
    os.execute("git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim")
end

require("qbornet.packer")
require("qbornet.set")
require("qbornet.remap")
require("qbornet.visual")
require("qbornet.ctags")
require("qbornet.modified")
require("qbornet.dap_settings")
