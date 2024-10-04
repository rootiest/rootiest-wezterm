--          ╭─────────────────────────────────────────────────────────╮
--          │                         PLUGINS                         │
--          ╰─────────────────────────────────────────────────────────╯

-- List of plugins to load
local plugins = {
	"battery",
	"hyperlinks",
	"resurrect",
	"smart_splits",
	"tabline",
}

-- Load all plugins
for _, plugin in ipairs(plugins) do
	require("plugins." .. plugin)
end
