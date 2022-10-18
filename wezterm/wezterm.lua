local wezterm = require 'wezterm';
-- local keys = require 'keys';
-- local colors = require 'colors';
local tab_bar_style = require 'tab';

-- FIXME how to get something like padding = auto?
local function recompute_padding(window)
  local window_dims = window:get_dimensions();
  local overrides = window:get_config_overrides() or {}

  if not window_dims.is_full_screen then
    if not overrides.window_padding then
      return;
    end
    overrides.window_padding = nil;
  else
    local new_padding = {
      left = '0.7%',
      right = '0.7%',
      top = '0.67%',
      bottom = 0,
    };
    if overrides.window_padding and new_padding.left == overrides.window_padding.left then
      -- padding is same, avoid triggering further changes
      return
    end
    overrides.window_padding = new_padding
  end
  window:set_config_overrides(overrides)
end

wezterm.on("window-resized", function(window, _ --[[pane]])
  recompute_padding(window)
end);

wezterm.on("window-config-reloaded", function(window)
  recompute_padding(window)
end);

return {
  use_ime = true,
  -- colors = colors,
  font = wezterm.font_with_fallback({
    "FiraCode Nerd Font",
    "Noto Sans CJK SC"
  }),
  font_size = 14,
  -- leader = keys.leader,
  -- keys = keys.keys,
  tab_bar_at_top = true,
  tab_bar_style = tab_bar_style,
  enable_scroll_bar = false,
  window_padding = {
    top = 0,
    bottom = 0,
    left = 0,
    right = 0,
  },
  window_decorations = "RESIZE",
  window_frame = {
    font = wezterm.font_with_fallback({
      "FiraCode Nerd Font",
      "Noto Sans CJK SC"
    }),
  },
  window_background_opacity = 0.7,
  initial_rows = 30,
  initial_cols = 100,
}
