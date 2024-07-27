-- Pull in the weztwerm API
local wezterm = require 'wezterm'

-- Config
local config = wezterm.config_builder()

-- Color Scheme
config.color_scheme = 'Gruvbox dark, medium (base16)'

-- Font
config.font = wezterm.font 'JetBrainsMono Nerd Font'

--
return config
