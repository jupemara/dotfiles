local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.automatically_reload_config = true
config.font_size = 15
config.color_scheme = 'Solarized Dark (Gogh)'
config.use_ime = true

-- fonts

config.font = wezterm.font_with_fallback{
  "HackGen Console NF",
  "JetBrains Mono",
}

-- blink
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.cursor_blink_rate = 512
config.default_cursor_style = "BlinkingBlock"

return config
