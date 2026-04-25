local chrome_path = vim.fn.exepath('google-chrome-stable')

if chrome_path ~= "" then
    -- use chrome as browser
    vim.g.mkdp_browser = chrome_path

    -- print url
    vim.g.mkdp_echo_preview_url = 1
else
    print("Warning mkdp: google-chrome-stable not found in PATH")
end

-- Use port 9999 by default
vim.g.mkdp_port = 9999

-- Reuse the same browser tab for all markdown previews
vim.g.mkdp_combine_preview = 1

-- Automatically update that tab when you switch markdown buffers
vim.g.mkdp_combine_preview_auto_refresh = 1
