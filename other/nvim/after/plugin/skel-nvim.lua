local function header_guard_cb(config)
    local filename = vim.fs.basename(config.filename)
    return string.upper(filename:gsub("[.]", "_"))
end

local function class_name_cb(config)
    return vim.fs.basename(config.filename):gsub("%.hpp", "")
end

require("skel-nvim").setup{
    mappings = {
        ['test_*.zig'] = 'test-zig.skel',
        ['main.zig'] = 'main-zig.skel',
        ['*.h'] = 'new-h.skel',
        ['*.hpp'] = 'new-hpp.skel', -- could be cool to use regexp instead of wildcard only '*'
        ['main.c'] = {'main-c.skel', '.clang-format', '.clang-tidy' },
        ['main.cpp'] = 'main-cpp.skel',
    },
    substitutions = {
        ['HEADER_GUARD']    = header_guard_cb,
        ['CLASS_NAME']      = class_name_cb,
    }
}
