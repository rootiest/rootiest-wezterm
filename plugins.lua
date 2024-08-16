--          ╭─────────────────────────────────────────────────────────╮
--          │                         PLUGINS                         │
--          ╰─────────────────────────────────────────────────────────╯
--  Load plugins from the 'plugins' directory

local M = {}

-- Function to require all Lua files in a directory
function M.require_plugins(dir)
	-- Check if the path exists
	local path = dir or os.getenv("HOME") .. "/.config/wezterm/plugins/"
	if not path then
		print("Directory path is nil. Unable to load plugins.")
		return
	end

	-- Open the directory
	local pfile, open_err = io.popen('ls "' .. path .. '"')
	if not pfile then
		print("Error opening directory:", open_err)
		return
	end

	-- Iterate over the files in the directory
	for file in pfile:lines() do
		if file:match("%.lua$") then
			local module_name = file:gsub("%.lua$", "")
			local status, require_err = pcall(require, "plugins." .. module_name)
			if not status then
				print("Error requiring plugin:", module_name, require_err)
			end
		end
	end

	pfile:close()
end

-- Function to update all plugins
function M.update_plugins()
	WEZTERM.plugin.update_all()
end

function M.setup()
	-- Load all plugins from the 'plugins' directory
	M.require_plugins()
end

return M
