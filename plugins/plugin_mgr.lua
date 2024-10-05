--          ╭─────────────────────────────────────────────────────────╮
--          │                     PLUGIN MANAGER                      │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

local wezterm = WEZTERM

PLUGIN_MGR = wezterm.plugin.require("https://gitlab.com/alecthegeek/wezterm-plugin-mgr.git")

return M
