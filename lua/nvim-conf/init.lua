local core = require "nvim-conf.core"
local au = require('nvim-conf.utils.au')

local M = {}

M.settings = {
    conf_file = vim.fn.stdpath('config') .. "/settings.conf",
    load_on_start = true,
    on_load = function (_)
        print("Data Loaded success")
    end,
}

M.data_loaded = {}

M.is_loaded = false

function M.get_value(name, default)
    if M.data_loaded[name] then
        return M.data_loaded[name]
    else
        return default
    end
end

function M.set_value (name, value)
    M.data_loaded[name] = value
    M.save()
end

function M.load()
    local data_loaded = core.load_data(M.settings.conf_file, true)
    if data_loaded ~= {} then
        M.data_loaded = data_loaded
    end
    M.settings.on_load(M.data_loaded)
    M.is_loaded = true
end

function M.save()
    core.save_data(M.settings.conf_file, M.data_loaded)
end


function M.setup(opts)
    -- load user options with default options
    M.settings = vim.tbl_extend('force', M.settings, opts)

    if M.settings.load_on_start == true then
        au.group('ConfigGroup', function (_)
            au({ 'VimEnter', 'BufReadPre', 'FileReadPre' }, { '*', M.load })
        end)
    end
end

return M
