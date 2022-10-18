local wezterm = require 'wezterm'

local tab_bar_style = {
  active_tab_left = wezterm.format {
    { Background = { Color = '#66CCFF' } },
    { Foreground = { Color = '#2b2042' } },
    { Text = ' ' },
  },
  active_tab_right = wezterm.format {
    { Background = { Color = '#0b0022' } },
    { Foreground = { Color = '#2b2042' } },
    { Text = '>' },
  },
  inactive_tab_left = wezterm.format {
    { Background = { Color = '#0b0022' } },
    { Foreground = { Color = '#1b1032' } },
    { Text = '<' },
  },
  inactive_tab_right = wezterm.format {
    { Background = { Color = '#0b0022' } },
    { Foreground = { Color = '#1b1032' } },
    { Text = '>' },
  },
}

return tab_bar_style;
