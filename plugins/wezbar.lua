--          ╭─────────────────────────────────────────────────────────╮
--          │                         WEZBAR                          │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

-- Load Wezbar plugin
WEZBAR = WEZTERM.plugin.require("https://github.com/nekowinston/wezterm-bar")

-- Configure wezbar
WEZBAR.apply_to_config(CONFIG, {
	position = "top",
	max_width = 32,
	dividers = "arrows", -- or "slant_left", "arrows", "rounded", false
	indicator = {
		leader = {
			enabled = true,
			off = " ",
			on = " ",
		},
		mode = {
			enabled = true,
			names = {
				resize_mode = "RESIZE",
				copy_mode = "VISUAL",
				search_mode = "SEARCH",
			},
		},
	},
	tabs = {
		numerals = "arabic", -- or "roman"
		pane_count = "superscript", -- or "subscript", false
		brackets = {
			active = { "", ":" },
			inactive = { "", ":" },
		},
	},
	clock = { -- note that this overrides the whole set_right_status
		enabled = true,
		format = "%a %R ", -- use https://wezfurlong.org/wezterm/config/lua/wezterm.time/Time/format.html
	},
})

return M
