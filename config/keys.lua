--          ╭─────────────────────────────────────────────────────────╮
--          │                          KEYS                           │
--          ╰─────────────────────────────────────────────────────────╯

-- Define action class
local act = WEZTERM.action

return {
	-- Leader key
	leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1500 },

	keys = {
		-- Split pane
		{ key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "_", mods = "LEADER|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

		-- Move pane
		{ key = "h", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Left") },
		{ key = "j", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Down") },
		{ key = "k", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Up") },
		{ key = "l", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Right") },

		-- Resize pane
		{ key = "h", mods = "ALT", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "j", mods = "ALT", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "k", mods = "ALT", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "l", mods = "ALT", action = act.AdjustPaneSize({ "Right", 1 }) },

		-- Miscellaneous
		{ key = "a", mods = "LEADER|CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },
		{ key = "F1", mods = "LEADER", action = act.ShowDebugOverlay },

		{ -- [S]ave Session
			key = "s",
			mods = "ALT",
			action = act.Multiple({
				WEZTERM.action_callback(function(_, _)
					RESURRECT.save_state(RESURRECT.workspace_state.get_workspace_state())
				end),
			}),
		},
		{ -- [R]estore Session
			key = "r",
			mods = "ALT",
			action = act.Multiple({
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
		{
			key = "!",
			mods = "LEADER | SHIFT",
			action = WEZTERM.action_callback(function(win, pane)
				local tab, window = pane:move_to_new_window()
			end),
		},
	},
}
