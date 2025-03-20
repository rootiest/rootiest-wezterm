--     __       __                     ________
--    /  |  _  /  |                   /        |
--    $$ | / \ $$ |  ______   ________$$$$$$$$/______    ______   _____  ____
--    $$ |/$  \$$ | /      \ /        |  $$ | /      \  /      \ /     \/    \
--    $$ /$$$  $$ |/$$$$$$  |$$$$$$$$/   $$ |/$$$$$$  |/$$$$$$  |$$$$$$ $$$$  |
--    $$ $$/$$ $$ |$$    $$ |  /  $$/    $$ |$$    $$ |$$ |  $$/ $$ | $$ | $$ |
--    $$$$/  $$$$ |$$$$$$$$/  /$$$$/__   $$ |$$$$$$$$/ $$ |      $$ | $$ | $$ |
--    $$$/    $$$ |$$       |/$$      |  $$ |$$       |$$ |      $$ | $$ | $$ |
--    $$/      $$/  $$$$$$$/ $$$$$$$$/   $$/  $$$$$$$/ $$/       $$/  $$/  $$/
--------------------------------------------------------------------------------
--                        https://github.com/wez/wezterm/

-- Load WezTerm module
WEZTERM = require("wezterm") --[[@as Wezterm]]
-- Load Config Builder
CONFIG = WEZTERM.config_builder()

-- Load Options
local opts = require("opts")

-- Apply config
for k, v in pairs(opts) do
	CONFIG[k] = v
end

-- Check for dev-modes
DEVMODE = pcall(require, "dev")

-- Check for user-configs
USERCONFIG = pcall(require, "user")

-- Load plugins
require("plugs")

-- Encrypt Sessions
require("encryption")

-- Load Menus
CONFIG.launch_menu = require("menus")

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
		move = "CTRL", -- modifier to use for pane movement
		resize = "ALT", -- modifier to use for pane resize
	},
})

--------- Update Plugins ----------
---Running this may cause slowdowns
-----------------------------------
--WEZTERM.plugin.update_all() ----
-- print(WEZTERM.plugin.list())
-----------------------------------

-- Return configuration
return CONFIG
