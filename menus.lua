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

	-- Find installed visual studio version(s) and add their compilation
	-- environment command prompts to the menu
	for _, vsvers in ipairs(wezterm.glob("Microsoft Visual Studio/20*", "C:/Program Files (x86)")) do
		local year = vsvers:gsub("Microsoft Visual Studio/", "")
		table.insert(launch_menu, {
			label = "x64 Native Tools VS " .. year,
			args = {
				"cmd.exe",
				"/k",
				"C:/Program Files (x86)/" .. vsvers .. "/BuildTools/VC/Auxiliary/Build/vcvars64.bat",
			},
		})
	end
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
