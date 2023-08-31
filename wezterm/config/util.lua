local M = {}

---@generic T
---@param dst T[]
---@param ... T[]
---@return T[]
function M.list_extend(dst, ...)
  for _, list in ipairs({ ... }) do
    for _, v in ipairs(list) do
      table.insert(dst, v)
    end
  end
  return dst
end

return M
