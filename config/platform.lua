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
	opts.front_end = "OpenGL"
	opts.prefer_egl = true
	opts.window_background_opacity = 0
	opts.win32_system_backdrop = "Mica"
	opts.use_fancy_tab_bar = false
	opts.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
elseif myos == "mac" then
	opts.default_prog = { "zsh" }
else
	opts.default_prog = { "fish" }
end

-- Check for Nix and respond accordingly
local is_nix = os.getenv("IN_NIX_SHELL")
local nix = false
if is_nix == "true" then
	opts.front_end = "WebGpu"
	nix = true
end

-- Set global variables for convenience
ISNIX = nix
MYOS = myos

-- Return the opts table
return opts
