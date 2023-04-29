-- Desc: smart-splits.nvim integration for wezterm
-- License: MIT
-- Upstream: https://github.com/mrjones2014/smart-splits.nvim

local W = require("wezterm")
local Act = W.action

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s) return string.gsub(s, "(.*[/\\])(.*)", "%2") end

local function is_vim(pane)
  local process_name = basename(pane:get_foreground_process_name())
  return process_name == "nvim" or process_name == "vim"
end

local key_directions = {
  h = "Left",
  j = "Down",
  k = "Up",
  l = "Right",
}

---@param action "resize"|"move"
---@param key string
local function smart(action, key)
  local mods
  local act
  local dir = key_directions[key]
  if action == "move" then
    mods = "CTRL"
    act = { ActivatePaneDirection = dir }
  elseif action == "resize" then
    mods = "ALT"
    act = { AdjustPaneSize = { dir, 3 } }
  end
  local vact = { SendKey = { key = key, mods = mods } }
  return {
    key = key,
    mods = mods,
    action = W.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action(vact, pane)
      else
        win:perform_action(act, pane)
      end
    end),
  }
end

---@param action "move"|"resize"
---@param key string
local function pane(action, key)
  local dir = key_directions[key]
  key = key:upper()
  if action == "move" then
    return {
      key = key,
      mods = "CTRL|SHIFT",
      action = Act.ActivatePaneDirection(dir),
    }
  elseif action == "resize" then
    return {
      key = key,
      mods = "ALT|SHIFT",
      action = Act.AdjustPaneSize({ dir, 3 }),
    }
  end
end

return {
  -- move between split panes
  smart("move", "h"),
  smart("move", "j"),
  smart("move", "k"),
  smart("move", "l"),
  pane("move", "h"),
  pane("move", "j"),
  pane("move", "k"),
  pane("move", "l"),
  -- resize panes
  smart("resize", "h"),
  smart("resize", "j"),
  smart("resize", "k"),
  smart("resize", "l"),
  pane("resize", "h"),
  pane("resize", "j"),
  pane("resize", "k"),
  pane("resize", "l"),
}