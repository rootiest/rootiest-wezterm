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

		-- Tab Manipulation
		{ key = "PageUp", mods = "CTRL", action = act.ActivateTabRelative(1) },
		{ key = "PageUp", mods = "SHIFT|CTRL", action = act.MoveTabRelative(1) },
		{ key = "PageDown", mods = "CTRL", action = act.ActivateTabRelative(-1) },
		{ key = "PageDown", mods = "SHIFT|CTRL", action = act.MoveTabRelative(-1) },

		-- Miscellaneous
		{ key = "a", mods = "LEADER|CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },
		{ key = ";", mods = "CTRL", action = act.ActivateCommandPalette },
		{ key = "F1", mods = "LEADER", action = act.ShowDebugOverlay },
		{ key = "s", mods = "LEADER|CTRL", action = act.ShowLauncherArgs({ flags = "DOMAINS" }) },
		{ key = "z", mods = "LEADER|CTRL", action = act.TogglePaneZoomState },
		{ key = "n", mods = "LEADER|CTRL", action = act.SpawnWindow },
		{
			key = "x",
			mods = "LEADER|CTRL",
			action = act.ShowLauncherArgs({
				title = "Quick Launch",
				flags = "FUZZY|TABS|DOMAINS|WORKSPACES|COMMANDS|LAUNCH_MENU_ITEMS|KEY_ASSIGNMENTS",
			}),
		},

		-- Naming
		{ -- Rename [W]orkspace
			key = "w",
			mods = "LEADER|CTRL",
			action = act.PromptInputLine({
				description = "Enter new name for the workspace:",
				action = WEZTERM.action_callback(function(window, _, line)
					if line then
						WEZTERM.mux.rename_workspace(window:active_workspace(), line)
					end
				end),
			}),
		},
		{ -- Rename [T]ab
			key = "t",
			mods = "LEADER|CTRL",
			action = act.PromptInputLine({
				description = "Enter new name for the tab:",
				action = WEZTERM.action_callback(function(window, _, line)
					if line then
						WEZTERM.mux.rename_workspace(window:active_workspace(), line)
					end
				end),
			}),
		},
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
			action = WEZTERM.action_callback(function(_, pane)
				pane:move_to_new_window()
			end),
		},
	},
}
