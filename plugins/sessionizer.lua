--          ╭─────────────────────────────────────────────────────────╮
--          │                       Sessionizer                       │
--          ╰─────────────────────────────────────────────────────────╯

local wezterm = WEZTERM
local config = CONFIG

SESSIONIZER = wezterm.plugin.require("https://github.com/mikkasendke/sessionizer.wezterm")
if SESSIONIZER then
	SESSIONIZER.apply_to_config(config)
end
