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
WEZTERM = require("wezterm")
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

--------- Update Plugins ----------
---Running this may cause slowdowns
-----------------------------------
-- WEZTERM.plugin.update_all() ----
-----------------------------------

-- Return configuration
return CONFIG
