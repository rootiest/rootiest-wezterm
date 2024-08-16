--          ╭─────────────────────────────────────────────────────────╮
--          │                      SMART-SPLITS                       │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

-- Load Smart-Splits plugin
SMART_SPLITS = WEZTERM.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

-- Apply Smart-Splits configuration
SMART_SPLITS.apply_to_config(CONFIG, {
	-- directional keys to use in order of: left, down, up, right
	direction_keys = {
		move = { "h", "j", "k", "l" }, -- Move with CTRL+H, CTRL+J, CTRL+K, CTRL+L
		resize = { "h", "j", "k", "l" }, -- Resize with ALT+h, ALT+j, ALT+k, ALT+l
	},
	-- modifier keys to combine with direction_keys
	modifiers = {
		move = "CTRL|SHIFT", -- modifier to use for pane movement
		resize = "ALT", -- modifier to use for pane resize
	},
})

return M
