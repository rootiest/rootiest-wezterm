--          ╭─────────────────────────────────────────────────────────╮
--          │                          KEYS                           │
--          ╰─────────────────────────────────────────────────────────╯

-- Define action table
local act = WEZTERM.action

return {
	leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1500 },
	keys = {
		{ key = "a", mods = "LEADER|CTRL", action = WEZTERM.action.SendKey({ key = "a", mods = "CTRL" }) },
		{ key = "|", mods = "LEADER|SHIFT", action = WEZTERM.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "_", mods = "LEADER|SHIFT", action = WEZTERM.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "h", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Left") },
		{ key = "l", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Right") },
		{ key = "k", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Up") },
		{ key = "j", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Down") },
		{ key = "h", mods = "ALT", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "l", mods = "ALT", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "k", mods = "ALT", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "j", mods = "ALT", action = act.AdjustPaneSize({ "Down", 1 }) },
		{
			key = "s",
			mods = "ALT",
			action = WEZTERM.action.Multiple({
				WEZTERM.action_callback(function(_, _)
					RESURRECT.save_state(RESURRECT.workspace_state.get_workspace_state())
				end),
			}),
		},
		{
			key = "r",
			mods = "ALT",
			action = WEZTERM.action.Multiple({
				WEZTERM.action_callback(function(win, pane)
					RESURRECT.fuzzy_load(win, pane, function(id, _)
						id = string.match(id, "([^/]+)$")
						id = string.match(id, "(.+)%..+$")
						local state = RESURRECT.load_state(id, "workspace")
						RESURRECT.workspace_state.restore_workspace(state, {
							relative = true,
							restore_text = true,
							on_pane_restore = RESURRECT.tab_state.default_on_pane_restore,
						})
					end)
				end),
			}),
		},
	},
}
