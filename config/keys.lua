--          ╭─────────────────────────────────────────────────────────╮
--          │                          KEYS                           │
--          ╰─────────────────────────────────────────────────────────╯

-- Define objects
local act = WEZTERM.action

return {
	--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ Leader key ━━━━━━━━━━━━━━━━━━━━━━━━━━
	leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1500 },
	--  ━━━━━━━━━━━━━━━━━━━━━━━━━ Global Key Mappings ━━━━━━━━━━━━━━━━━━━━━
	keys = {
		-- Close window
		{ key = "q", mods = "LEADER|SHIFT|CTRL", action = act.QuitApplication },
		-- Split pane
		{ key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "_", mods = "LEADER|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

		-- Move pane
		{ key = "h", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Left") },
		{ key = "j", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Down") },
		{ key = "k", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Up") },
		{ key = "l", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Right") },
		-- Move pane to new window
		{
			key = "!",
			mods = "LEADER | SHIFT",
			action = WEZTERM.action_callback(function(_, pane)
				pane:move_to_new_window()
			end),
		},

		-- Toggle pane zoom
		{
			key = "z",
			mods = "SHIFT|CTRL",
			action = act.TogglePaneZoomState,
		},
		{
			key = "z",
			mods = "LEADER",
			action = act.TogglePaneZoomState,
		},

		-- Close pane
		{ key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
		{ key = "q", mods = "SHIFT|CTRL", action = act.CloseCurrentPane({ confirm = true }) },

		-- Resize pane
		{ key = "h", mods = "ALT", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "j", mods = "ALT", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "k", mods = "ALT", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "l", mods = "ALT", action = act.AdjustPaneSize({ "Right", 1 }) },
		-- Resize pane mode
		{ key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_mode", one_shot = false }) },
		{ key = "p", mods = "LEADER", action = act.ActivateKeyTable({ name = "window_mode", one_shot = false }) },

		-- Tab Manipulation
		{ key = "PageUp", mods = "CTRL", action = act.ActivateTabRelative(1) },
		{ key = "PageUp", mods = "SHIFT|CTRL", action = act.MoveTabRelative(1) },
		{ key = "PageDown", mods = "CTRL", action = act.ActivateTabRelative(-1) },
		{ key = "PageDown", mods = "SHIFT|CTRL", action = act.MoveTabRelative(-1) },

		{ -- Quick launch
			key = "x",
			mods = "LEADER|CTRL",
			action = act.ShowLauncherArgs({
				title = "Quick Launch",
				flags = "FUZZY|TABS|DOMAINS|WORKSPACES|COMMANDS|LAUNCH_MENU_ITEMS|KEY_ASSIGNMENTS",
			}),
		},

		-- Search
		{ key = "f", mods = "LEADER", action = act.Search("CurrentSelectionOrEmptyString") },
		{ key = "f", mods = "SHIFT|CTRL", action = act.Search("CurrentSelectionOrEmptyString") },

		-- Miscellaneous
		{ key = "a", mods = "LEADER|CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },
		{ key = ";", mods = "CTRL", action = act.ActivateCommandPalette },
		{ key = "F1", mods = "LEADER", action = act.ShowDebugOverlay },
		{
			key = "u",
			mods = "LEADER|CTRL",
			action = act.AttachDomain("SSH:aws-discord"),
		},
		{
			key = "s",
			mods = "LEADER|CTRL",
			action = act.ShowLauncherArgs({ title = "Connect to SSH server", flags = "FUZZY|DOMAINS" }),
		},
		{ key = "z", mods = "LEADER|CTRL", action = act.TogglePaneZoomState },
		{ key = "n", mods = "LEADER|CTRL", action = act.SpawnWindow },
		{ key = "x", mods = "LEADER", action = act.ActivateCopyMode },

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
				action = WEZTERM.action_callback(function(_, pane, line)
					if line then
						local tab = pane:tab()
						tab:set_title(line)
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
					RESURRECT.window_state.save_window_action()
				end),
			}),
		},
		{ -- [R]estore Session
			key = "r",
			mods = "ALT",
			action = WEZTERM.action_callback(function(win, pane)
				RESURRECT.fuzzy_load(win, pane, function(id)
					local type = string.match(id, "^([^/]+)") -- match before '/'
					id = string.match(id, "([^/]+)$") -- match after '/'
					id = string.match(id, "(.+)%..+$") -- remove file extension
					local state
					if type == "workspace" then
						state = RESURRECT.load_state(id, "workspace")
						RESURRECT.workspace_state.restore_workspace(state, {
							relative = true,
							restore_text = true,
							on_pane_restore = RESURRECT.tab_state.default_on_pane_restore,
						})
					elseif type == "window" then
						state = RESURRECT.load_state(id, "window")
						RESURRECT.window_state.restore_window(pane:window(), state, {
							relative = true,
							restore_text = true,
							on_pane_restore = RESURRECT.tab_state.default_on_pane_restore,
							-- uncomment this line to use active tab when restoring
							-- tab = win:active_tab(),
						})
					end
				end)
			end),
		},
	},

	--  ━━━━━━━━━━━━━━━━━━━━━━ Conditional Key Mappings ━━━━━━━━━━━━━━━━━━━
	key_tables = {
		resize_mode = { ---------- Resize Pane Mode -------------------------
			{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
			{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },

			{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
			{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },

			{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
			{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },

			{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
			{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },

			-- Cancel the mode by pressing escape
			{ key = "Escape", action = "PopKeyTable" },
		},
		window_mode = { --------- Activate Pane Mode ----------------------
			{ key = "LeftArrow", action = act.ActivatePaneDirection("Left") },
			{ key = "h", action = act.ActivatePaneDirection("Left") },

			{ key = "RightArrow", action = act.ActivatePaneDirection("Right") },
			{ key = "l", action = act.ActivatePaneDirection("Right") },

			{ key = "UpArrow", action = act.ActivatePaneDirection("Up") },
			{ key = "k", action = act.ActivatePaneDirection("Up") },

			{ key = "DownArrow", action = act.ActivatePaneDirection("Down") },
			{ key = "j", action = act.ActivatePaneDirection("Down") },
		},
	},

	--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Mouse Bindings ━━━━━━━━━━━━━━━━━━━━━━━━
	mouse_bindings = {
		{ -- Left-Click: (Up) Select Text
			event = { Up = { streak = 1, button = "Left" } },
			mods = "NONE",
			action = act.CompleteSelection("ClipboardAndPrimarySelection"),
		},
		{ -- Ctrl+Left-Click: (Up) Open Hyperlink
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = act.OpenLinkAtMouseCursor,
		},
		-- { -- Ctrl+Double-Left-Click: (Up) Open Hyperlink
		-- 	event = { Up = { streak = 2, button = "Left" } },
		-- 	mods = "CTRL",
		-- 	action = act.OpenLinkAtMouseCursor,
		-- },
		{ -- Ctrl+WheelUp: Go to previous tab
			event = { Down = { streak = 1, button = { WheelUp = 1 } } },
			mods = "CTRL",
			action = act.ActivateTabRelative(-1),
		},
		{ -- Ctrl+WheelDown: Go to next tab
			event = { Down = { streak = 1, button = { WheelDown = 1 } } },
			mods = "CTRL",
			action = act.ActivateTabRelative(1),
		},
	},
}
