-- Desc: smart-splits.nvim integration for wezterm
-- License: MIT
-- Upstream: https://github.com/mrjones2014/smart-splits.nvim

local W = require("wezterm")

---@param key string
---@param mods string?
---@param fb table
local function send_to_vim(key, mods, fb)
  return {
    key = key,
    mods = mods,
    action = W.action_callback(function(win, pane)
      if pane:get_user_vars().IS_NVIM == "true" then
        win:perform_action({ SendKey = { key = key, mods = mods } }, pane)
      else
        win:perform_action(fb, pane)
      end
    end),
  }
end

---@param dir string
---@param key string
---@param mods string?
local function move(dir, key, mods)
  return send_to_vim(key, mods, { ActivatePaneDirection = dir })
end

---@param dir string
---@param key string
---@param mods string?
local function resize(dir, key, mods)
  return send_to_vim(key, mods, { AdjustPaneSize = { dir, 3 } })
end

return {
  -- move between split panes
  move("Left", "h", "CTRL"),
  move("Down", "j", "CTRL"),
  move("Up", "k", "CTRL"),
  move("Right", "l", "CTRL"),
  -- resize panes
  resize("Left", "h", "ALT"),
  resize("Down", "j", "ALT"),
  resize("Up", "k", "ALT"),
  resize("Right", "l", "ALT"),
}
