-- Desc: smart-splits.nvim integration for wezterm
-- License: MIT
-- Upstream: https://github.com/mrjones2014/smart-splits.nvim

local W = require("wezterm")

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s) return string.gsub(s, "(.*[/\\])(.*)", "%2") end

local function is_vim(pane)
  local process_name = basename(pane:get_foreground_process_name())
  return process_name == "nvim" or process_name == "vim"
end

local direction_keys = {
  Left = "h",
  Down = "j",
  Up = "k",
  Right = "l",
  -- reverse lookup
  h = "Left",
  j = "Down",
  k = "Up",
  l = "Right",
}

---@param action "resize"|"move"
---@param mods string
---@param key string
return function(action, mods, key)
  return {
    key = key,
    mods = mods,
    action = W.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = mods },
        }, pane)
      elseif action == "resize" then
        win:perform_action({
          AdjustPaneSize = { direction_keys[key], 3 },
        }, pane)
      else
        win:perform_action({
          ActivatePaneDirection = direction_keys[key],
        }, pane)
      end
    end),
  }
end
