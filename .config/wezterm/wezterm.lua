local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.automatically_reload_config = true

-- fonts
config.color_scheme = 'Solarized Dark (Gogh)'
config.font = wezterm.font_with_fallback{
  "HackGen Console NF",
  "JetBrains Mono",
}
config.font_size = 15
config.use_ime = true

-- blink
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.cursor_blink_rate = 512
config.default_cursor_style = "BlinkingBlock"

-- background
config.window_background_opacity = 0.85

-- window
config.hide_tab_bar_if_only_one_tab = true
wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
  return ''
end)

-- window close confirmation
config.keys = {
  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentTab { confirm = true },
  }
}
config.skip_close_confirmation_for_processes_named = {}
config.window_close_confirmation = 'AlwaysPrompt'

-- bell
config.audible_bell = 'Disabled'

return config
