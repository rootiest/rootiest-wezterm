--          ╭─────────────────────────────────────────────────────────╮
--          │                       OS OPTIONS                        │
--          ╰─────────────────────────────────────────────────────────╯

-- Load WezTerm module
local wezterm = WEZTERM

-- Define the opts table
local opts = {}

-- -- Get the OS string
local os_string = wezterm.target_triple:lower()
local myos = ""
--
-- -- Determine the OS
if os_string:find("windows") then
	myos = "win"
else
	if os_string:find("darwin") then
		myos = "mac"
	else
		myos = "linux"
	end
end

-- Set OS-specific options
if myos == "win" then
	opts.default_prog = { "pwsh.exe" }
	opts.term = "xterm-256color"
elseif myos == "mac" then
	opts.default_prog = { "zsh" }
else
	opts.default_prog = { "fish" }
end

MYOS = myos

-- Return the opts table
return opts
