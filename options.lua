--          ╭─────────────────────────────────────────────────────────╮
--          │                         OPTIONS                         │
--          ╰─────────────────────────────────────────────────────────╯
-- Load and merge configurations from the 'config' directory

local M = {}

-- Function to require all Lua files in a directory and merge them
local function require_configs(dir)
  -- Check if the path exists
	local path = dir or os.getenv("HOME") .. "/.config/wezterm/config/"
	if not path then
		print("Directory path is nil. Unable to load configurations.")
		return
	end

  -- Open the directory
	local pfile, open_err = io.popen('ls "' .. path .. '"')
	if not pfile then
		print("Error opening directory:", open_err)
		return
	end

	local configs = {}

  -- Iterate over the files in the directory
	for file in pfile:lines() do
		if file:match("%.lua$") then
			local module_name = file:gsub("%.lua$", "")
			local status, config = pcall(require, "config." .. module_name)
			if status and type(config) == "table" then
				configs[module_name] = config
			elseif not status then
				print("Error requiring config:", module_name, config)
			else
				print("Warning: Config not a table:", module_name)
			end
		end
	end

	pfile:close()

	-- Merge configurations into CONFIG
	for _, config in pairs(configs) do
		for k, v in pairs(config) do
			CONFIG[k] = v
		end
	end
end

function M.setup()
	-- Load all configurations from the 'config' directory
	require_configs()
end

return M
