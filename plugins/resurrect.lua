--          ╭─────────────────────────────────────────────────────────╮
--          │                        RESURRECT                        │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

-- Load Resurrect plugin
RESURRECT = WEZTERM.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

-- Set the keyfile
local key = WEZTERM.home_dir .. "/.config/.private/key.txt"

---@function Check if a file exists
---@param file string The file path to check
---@return boolean exists True if the file exists, false otherwise
local function file_exists(file)
	local f = io.open(file, "r")
	if f then
		f:close()
		return true
	end
	return false
end

if file_exists(key) then
	RESURRECT.set_encryption({
		enable = true,
		method = "age", -- "age" is the default encryption method, but you can also specify "rage" or "gpg"
		private_key = key, -- if using "gpg", you can omit this
		public_key = "age1q80h5jsp9d48kggf9kra82xkgyaqdnehqenm003ftapem9re7ytqp9hr6h",
	})
end

-- Set the periodic save interval
RESURRECT.periodic_save({ interval_seconds = 60, save_workspaces = true, save_windows = true })

-- load the state whenever I create a new workspace
WEZTERM.on("smart_workspace_switcher.workspace_switcher.created", function(window, _, label)
	local workspace_state = RESURRECT.workspace_state

	workspace_state.restore_workspace(RESURRECT.load_state(label, "workspace"), {
		window = window,
		relative = true,
		restore_text = true,
		on_pane_restore = RESURRECT.tab_state.default_on_pane_restore,
	})
end)

-- Save the state whenever I select a workspace
WEZTERM.on("smart_workspace_switcher.workspace_switcher.selected", function(_, _, _)
	local workspace_state = RESURRECT.workspace_state
	RESURRECT.save_state(workspace_state.get_workspace_state())
end)

return M
