--          ╭─────────────────────────────────────────────────────────╮
--          │                         KEYMAPS                         │
--          ╰─────────────────────────────────────────────────────────╯

local wezterm = WEZTERM
local act = wezterm.action

-- Set up some reference values
local Chord = "SHIFT|CTRL"
local LeaderChord = "LEADER|SHIFT|CTRL"
local LeaderShift = "LEADER|SHIFT"
local LeaderCtrl = "LEADER|CTRL"

local FuzzyLaunch = "FUZZY|TABS|DOMAINS|WORKSPACES|COMMANDS|LAUNCH_MENU_ITEMS|KEY_ASSIGNMENTS"

---@diagnostic disable-next-line: undefined-field
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
local tunicodes = require("plugins/tunicodes")

local opts = {
	--  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ Leader key ━━━━━━━━━━━━━━━━━━━━━━━━━━
	leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1500 },
	--  ━━━━━━━━━━━━━━━━━━━━━━━━━ Global Key Mappings ━━━━━━━━━━━━━━━━━━━━━
	keys = {
		-- Close window
		{ key = "q", mods = LeaderChord, action = act.QuitApplication },
		-- Split pane
		{ key = "|", mods = LeaderShift, action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "_", mods = LeaderShift, action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

		-- Move pane
		{ key = "h", mods = Chord, action = act.ActivatePaneDirection("Left") },
		{ key = "j", mods = Chord, action = act.ActivatePaneDirection("Down") },
		{ key = "k", mods = Chord, action = act.ActivatePaneDirection("Up") },
		{ key = "l", mods = Chord, action = act.ActivatePaneDirection("Right") },
		-- Move pane to new window
		{
			key = "!",
			mods = LeaderShift,
			action = wezterm.action_callback(function(_, pane)
				pane:move_to_new_window()
			end),
		},

		-- Toggle pane zoom
		{
			key = "z",
			mods = Chord,
			action = act.TogglePaneZoomState,
		},
		{
			key = "z",
			mods = "LEADER",
			action = act.TogglePaneZoomState,
		},
		-- Reload Config
		{ key = "F5", mods = "LEADER", action = act.ReloadConfiguration },

		-- Close pane
		{ key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
		{ key = "q", mods = Chord, action = act.CloseCurrentPane({ confirm = true }) },

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
		{ key = "PageUp", mods = Chord, action = act.MoveTabRelative(1) },
		{ key = "PageDown", mods = "CTRL", action = act.ActivateTabRelative(-1) },
		{ key = "PageDown", mods = Chord, action = act.MoveTabRelative(-1) },

		{ -- Quick launch
			key = "x",
			mods = LeaderCtrl,
			action = act.ShowLauncherArgs({
				title = "Quick Launch",
				flags = FuzzyLaunch,
			}),
		},

		-- Search
		{ key = "f", mods = "LEADER", action = act.Search("CurrentSelectionOrEmptyString") },
		{ key = "f", mods = Chord, action = act.Search("CurrentSelectionOrEmptyString") },

		-- Miscellaneous
		{ key = "a", mods = LeaderCtrl, action = act.SendKey({ key = "a", mods = "CTRL" }) },
		{ key = ";", mods = "CTRL", action = act.ActivateCommandPalette },
		{ key = "F1", mods = "LEADER", action = act.ShowDebugOverlay },
		{
			key = "u",
			mods = LeaderCtrl,
			action = act.AttachDomain("SSH:aws-discord"),
		},
		{
			key = "s",
			mods = LeaderCtrl,
			action = act.ShowLauncherArgs({ title = "Connect to SSH server", flags = "FUZZY|DOMAINS" }),
		},
		{ key = "z", mods = LeaderCtrl, action = act.TogglePaneZoomState },
		{ key = "n", mods = LeaderCtrl, action = act.SpawnWindow },
		{ key = "x", mods = "LEADER", action = act.ActivateCopyMode },

		-- Naming
		{ -- Rename [W]orkspace
			key = "w",
			mods = LeaderCtrl,
			action = act.PromptInputLine({
				description = "Enter new name for the workspace:",
				action = wezterm.action_callback(function(window, _, line)
					if line then
						wezterm.mux.rename_workspace(window:active_workspace(), line)
					end
				end),
			}),
		},
		{ -- Rename [T]ab
			key = "t",
			mods = LeaderCtrl,
			action = act.PromptInputLine({
				description = "Enter new name for the tab:",
				action = wezterm.action_callback(function(_, pane, line)
					if line then
						local tab = pane:tab()
						---@diagnostic disable-next-line: need-check-nil
						tab:set_title(line)
					end
				end),
			}),
		},
		{ -- Save [w]orkspace State
			key = "w",
			mods = "ALT",
			action = wezterm.action_callback(function()
				resurrect.save_state(resurrect.workspace_state.get_workspace_state())
			end),
		},
		{ -- Save [W]indow State
			key = "W",
			mods = "ALT",
			action = resurrect.window_state.save_window_action(),
		},
		{ -- [S]ave Session
			key = "s",
			mods = "ALT",
			action = act.Multiple({
				wezterm.action_callback(function(_, _)
					resurrect.save_state(resurrect.workspace_state.get_workspace_state())
					resurrect.window_state.save_window_action()
				end),
			}),
		},
		{ -- [R]estore Session
			key = "r",
			mods = "ALT",
			action = wezterm.action_callback(function(win, pane)
				resurrect.fuzzy_load(win, pane, function(id)
					local type = string.match(id, "^([^/]+)") -- match before '/'
					id = string.match(id, "([^/]+)$") -- match after '/'
					id = string.match(id, "(.+)%..+$") -- remove file extension
					local state
					if type == "workspace" then
						state = resurrect.load_state(id, "workspace")
						resurrect.workspace_state.restore_workspace(state, {
							relative = true,
							restore_text = true,
							on_pane_restore = resurrect.tab_state.default_on_pane_restore,
						})
					elseif type == "window" then
						state = resurrect.load_state(id, "window")
						resurrect.window_state.restore_window(pane:window(), state, {
							relative = true,
							restore_text = true,
							on_pane_restore = resurrect.tab_state.default_on_pane_restore,
							-- uncomment this line to use active tab when restoring
							-- tab = win:active_tab(),
						})
					end
				end)
			end),
		},
		{ -- [.] Insert Unicode and Emoji symbols
			key = ".",
			mods = LeaderCtrl,
			action = tunicodes.DefaultAction,
		},
		{ key = "u", mods = LeaderCtrl, action = act.EmitEvent("toggle-tabbar") },
		{
			key = "b",
			mods = "LEADER|CTRL",
			action = wezterm.action_callback(function(window, pane)
				window:perform_action(
					wezterm.action.SpawnCommandInNewTab({
						args = { "btop" },
					}),
					pane
				)
				window:active_tab():set_title("Resource Monitor")
			end),
		},
		{
			key = "z",
			mods = "LEADER|CTRL",
			action = wezterm.action_callback(function(window, pane)
				window:perform_action(
					wezterm.action.SplitPane({
						command = { args = { os.getenv("SHELL"), "-c", "lazygit" } },
						direction = "Right",
					}),
					pane
				)
				---@diagnostic disable-next-line: param-type-mismatch
				window:perform_action(wezterm.action.TogglePaneZoomState, pane)
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
		copy_mode = {
			{ key = "Tab", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
			{ key = "Tab", mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "Enter", mods = "NONE", action = act.CopyMode("MoveToStartOfNextLine") },
			{ key = "Escape", mods = "NONE", action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }) },
			{ key = "Space", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = ",", mods = "NONE", action = act.CopyMode("JumpReverse") },
			{ key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
			{ key = ";", mods = "NONE", action = act.CopyMode("JumpAgain") },
			{ key = "F", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
			{ key = "F", mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
			{ key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
			{ key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
			{ key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
			{ key = "H", mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
			{ key = "L", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },
			{ key = "L", mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },
			{ key = "M", mods = "NONE", action = act.CopyMode("MoveToViewportMiddle") },
			{ key = "M", mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
			{ key = "O", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
			{ key = "O", mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
			{ key = "T", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
			{ key = "T", mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
			{ key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "V", mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
			{ key = "b", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
			{ key = "c", mods = "CTRL", action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }) },
			{ key = "d", mods = "CTRL", action = act.CopyMode({ MoveByPage = 0.5 }) },
			{ key = "e", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },
			{ key = "f", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = false } }) },
			{ key = "f", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
			{ key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
			{ key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
			{ key = "g", mods = "CTRL", action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }) },
			{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
			{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
			{ key = "m", mods = "ALT", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "o", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEnd") },
			{ key = "q", mods = "NONE", action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }) },
			{ key = "t", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = true } }) },
			{ key = "u", mods = "CTRL", action = act.CopyMode({ MoveByPage = -0.5 }) },
			{ key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },
			{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
			{
				key = "y",
				mods = "NONE",
				action = act.Multiple({
					{ CopyTo = "ClipboardAndPrimarySelection" },
					{ Multiple = { "ScrollToBottom", { CopyMode = "Close" } } },
				}),
			},
			{ key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
			{ key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },
			{ key = "End", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "Home", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
			{ key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "LeftArrow", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },
			{ key = "RightArrow", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
			{ key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
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
		{
			event = { Down = { streak = 1, button = "Right" } },
			mods = "NONE",
			action = act.PasteFrom("Clipboard"),
		},
	},
}

return opts
