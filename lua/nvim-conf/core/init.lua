local utils = require("nvim-conf.utils")

local M = {}

function M.load_data(file_path, create_if_not_exists)
    local file, _ = io.open (file_path, "r")
    local data_loaded = {}
    if file == nil and create_if_not_exists == true then
        local f = io.open(file_path, "w")
        f:write("")
    else
        local content = file:read("*a")
        local lines_arr = utils.get_lines(content)
        if next(lines_arr) ~= nil then
            for v in pairs(lines_arr) do
                local line = lines_arr[v]
                if not utils.is_empty(line) and not string.sub(line, 1, 1) == "#" then
                    local raw_values = utils.split_str(line, "=")
                    data_loaded[raw_values[1]] = raw_values[2]:gsub("#.*")
                end
            end
        end
        file:close()
    end
    return data_loaded
end

function M.save_data(file_path, data_to_save)
    local file = io.open(file_path, "w")
    local text_save = ""
    for k, v in pairs(data_to_save) do
        if type(v) == "number" or type(v) == "boolean" or type(v) == "string" then
            text_save = text_save .. k .. "=" .. v .. "\n"
        end
    end
    file:write(text_save)
    file:close()
end

return M
