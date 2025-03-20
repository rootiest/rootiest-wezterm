--          ╭─────────────────────────────────────────────────────────╮
--          │                        RESURRECT                        │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

-- Load Resurrect plugin
RESURRECT = WEZTERM.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

-- Set the periodic save interval
RESURRECT.state_manager.periodic_save({ interval_seconds = 60, save_workspaces = true, save_windows = true })

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
