-- Desc: smart-splits.nvim integration for wezterm
-- License: MIT
-- Upstream: https://github.com/mrjones2014/smart-splits.nvim

local W = require("wezterm")

local DIRECTION_KEYS = {
  Left = "h",
  Down = "j",
  Up = "k",
  Right = "l",
}

---@param key string
---@param mods string?
---@param fb table
local function send_to_vim(key, mods, fb)
  return W.action_callback(function(win, pane)
    if pane:get_user_vars().IS_NVIM == "true" then
      win:perform_action({ SendKey = { key = key, mods = mods } }, pane)
    else
      win:perform_action(fb, pane)
    end
  end)
end

---@param dir string
---@param mods string?
local function move(dir, mods)
  local key = DIRECTION_KEYS[dir]
  return {
    key = key,
    mods = mods,
    action = send_to_vim(key, mods, { ActivatePaneDirection = dir }),
  }
end

---@param dir string
---@param mods string?
local function resize(dir, mods)
  local key = DIRECTION_KEYS[dir]
  return {
    key = key,
    mods = mods,
    action = send_to_vim(key, mods, { AdjustPaneSize = { dir, 3 } }),
  }
end

return {
  -- move between split panes
  move("Left", "CTRL"),
  move("Up", "CTRL"),
  move("Down", "CTRL"),
  move("Right", "CTRL"),
  -- resize panes
  resize("Left", "CTRL|SHIFT"),
  resize("Up", "CTRL|SHIFT"),
  resize("Down", "CTRL|SHIFT"),
  resize("Right", "CTRL|SHIFT"),
}
