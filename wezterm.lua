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
local configs = require("configs")

-- Apply config
for k, v in pairs(configs) do
	CONFIG[k] = v
end

-- Check for dev-modes
DEVMODE = pcall(require, "dev")

-- Load Plugins
require("plugins.battery")
require("plugins.hyperlinks")
require("plugins.resurrect")
require("plugins.smart_splits")
require("plugins.tabline")

--------- Update Plugins ----------
---Running this may cause slowdowns
-----------------------------------
-- WEZTERM.plugin.update_all() ----
-----------------------------------

-- Return configuration
return CONFIG
