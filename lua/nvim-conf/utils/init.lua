local M = {}

M.is_empty = function (s)
    return s == nil or s == ''
end

M.get_lines = function (str)
    local t = {}
    local function helper(line) table.insert(t, line) return "" end
    helper((str:gsub("(.-)\r?\n", helper)))
    return t
end

M.split_str = function (str, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for s in string.gmatch(str, "([^" .. sep .. "]+)") do
        table.insert(t, s)
    end
    return t
end

return M
