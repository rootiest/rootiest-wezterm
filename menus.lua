--          ╭─────────────────────────────────────────────────────────╮
--          │                          Menus                          │
--          ╰─────────────────────────────────────────────────────────╯

local wezterm = WEZTERM
local launch_menu = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	table.insert(launch_menu, {
		label = "PowerShell",
		args = { "pwsh.exe", "-NoLogo" },
	})
end

-- Set up btop launcher
if wezterm.target_triple ~= "x86_64-pc-windows-msvc" then
	table.insert(launch_menu, {
		label = "btop",
		args = { "btop" },
	})
end

-- Set up btop launcher split using wezterm cli
if wezterm.target_triple ~= "x86_64-pc-windows-msvc" then
	table.insert(launch_menu, {
		label = "btop split",
		args = { "wezterm", "cli", "split-pane", "--", "btop" },
	})
end

return launch_menu
