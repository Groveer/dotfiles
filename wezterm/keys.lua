local wezterm = require 'wezterm';

-- this file provid a tmux-like keymapping

local leader = {
  key="b", mods="CTRL",
  timeout_milliseconds=1000
}

local keys = {
  {
    key = "z", mods = "LEADER",
    action = "TogglePaneZoomState"
  },
  {
    key = "-", mods = "LEADER",
    action = wezterm.action{
      SplitVertical = {
        domain = "CurrentPaneDomain"
      }
    }
  },
  {
    key = "\\", mods = "LEADER",
    action = wezterm.action{
      SplitHorizontal = {
        domain = "CurrentPaneDomain"
      }
    }
  },
  {
    key = "h", mods = "LEADER",
    action = wezterm.action{
      ActivatePaneDirection="Left"
    }
  },
  {
    key = "l", mods = "LEADER",
    action = wezterm.action{
      ActivatePaneDirection = "Right"
    }
  },
  {
    key = "k", mods = "LEADER",
    action = wezterm.action{
      ActivatePaneDirection = "Up"
    }
  },
  {
    key = "j", mods = "LEADER",
    action = wezterm.action{
      ActivatePaneDirection = "Down"
    }
  },
  {
    key = "c", mods = "LEADER",
    action = wezterm.action{
      SpawnTab = "CurrentPaneDomain"
    }
  },
  {
    key = ";", mods = "LEADER",
    action = wezterm.action{
      SpawnCommandInNewTab = {
        args = {"nvim", "/Users/lxz/.config/wezterm/wezterm.lua"}
      },
    }
  },
  {
    key = "Tab", mods = "LEADER",
    action = wezterm.action{
      ActivateTabRelative=1,
    }
  },
  {
    key = "Tab", mods = "LEADER|SHIFT",
    action = wezterm.action{
      ActivateTabRelative=-1,
    }
  },
}

for i = 1, 9 do
  table.insert(
    keys, {
      key = tostring(i),
      mods = "LEADER",
      action = wezterm.action{ ActivateTab = i-1 },
    }
  )
end

return {
  leader = leader,
  keys = keys,
}
