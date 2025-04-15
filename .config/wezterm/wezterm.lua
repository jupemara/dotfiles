local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.automatically_reload_config = true
config.font_size = 15
config.color_scheme = 'Solarized Dark Higher Contrast (Gogh)'
config.use_ime = true
config.font_dirs = { 'fonts' }
config.font = wezterm.font(
  "HackGen Console NF"
)

return config
