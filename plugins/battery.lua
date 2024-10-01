--          ╭─────────────────────────────────────────────────────────╮
--          │                         Battery                         │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

local wezterm = WEZTERM

if DEVMODE then
	-- Use the local dev plugin
	BATTERIES = wezterm.plugin.require("file://" .. wezterm.home_dir .. "/projects/battery.wez")
else
	-- Use the remote plugin
	BATTERIES = wezterm.plugin.require("https://github.com/rootiest/battery.wez")
end

-- Invert the icon color brightness
BATTERIES.invert = true

return M
