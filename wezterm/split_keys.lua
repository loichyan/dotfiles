-- Desc: smart-splits.nvim integration for wezterm
-- License: MIT
-- Upstream: https://github.com/mrjones2014/smart-splits.nvim

local W = require("wezterm")
-- local Act = W.action

local function is_vim(pane)
  return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
  Left = "h",
  Down = "j",
  Up = "k",
  Right = "l",
}

---@param dir string
---@param mods string?
local function move(dir, mods)
  local key = direction_keys[dir]
  return {
    key = key,
    mods = mods,
    action = W.action_callback(function(win, pane)
      if is_vim(pane) then
        win:perform_action({ SendKey = { key = key, mods = mods } }, pane)
      else
        win:perform_action({ ActivatePaneDirection = dir }, pane)
      end
    end),
  }
end

---@param dir string
---@param mods string?
local function resize(dir, mods)
  local key = direction_keys[dir]
  return {
    key = key,
    mods = mods,
    action = W.action_callback(function(win, pane)
      if is_vim(pane) then
        win:perform_action({ SendKey = { key = key, mods = mods } }, pane)
      else
        win:perform_action({ AdjustPaneSize = { dir, 3 } }, pane)
      end
    end),
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
