--          ╭─────────────────────────────────────────────────────────╮
--          │                          TYPES                          │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

local wezterm = WEZTERM

-- stylua: ignore start
M.harfbuzz_features = {
--  ╭──────── Character Varients ─────╮
--  ╰── Varient              Result ──╯
        "VSAA=1",     --       ~
        "VSAG=1",     --      ( )
        "VSAH=7",     --      { }
        "VSAI=2",     --     << >>
        "VSAO=2",     --       %
        "VSAJ=8",     --       #
        "VSAK=1",     --       &
        "VSAL=2",     --       @
        "VSAM=9",     --       $
        "VSAP=1",     --      | /
        "VSAQ=1",     --       ?
        "VLAB=5",     --       !=
        "VLAD=1",     --       --
        "cv01=0",     --       1
        "cv02=0",     --       2
        "cv03=1",     --       3
        "cv05=1",     --       5
        "cv06=1",     --       6
        "cv07=4",     --       7
        "cv08=1",     --       8
        "cv09=1",     --       9
        "cv10=7",     --       0
        "cv17=2",     --       G
        "cv19=2",     --       I
        "cv26=9",     --       Q
        "cv41=7",     --       f
        "cv42=1",     --       g
        "cv45=2",     --       j
        "cv46=24",    --       k
        "cv47=8",     --       l
        "dlig=1",  --  <= >= </ </> /> <>
}
-- stylua: ignore end


-- stylua: ignore start
M.harfbuzz_rootiest = {
--  ╭──────── Character Varients ─────╮
--  ╰── Varient              Result ──╯
        "cv39=4",     --       d
        "VSAL=8",     --       @
        "VSAM=9",     --       $
        "VSAN=9",     --       ¢
        "VSAO=2",     --       %
}
-- stylua: ignore end

M.maple_features = {
	"ss01",
	"ss02",
	"ss03",
	"ss04",
	"ss05",
}

M.hours_icons = {
	["00"] = wezterm.nerdfonts.md_clock_time_twelve_outline,
	["01"] = wezterm.nerdfonts.md_clock_time_one_outline,
	["02"] = wezterm.nerdfonts.md_clock_time_two_outline,
	["03"] = wezterm.nerdfonts.md_clock_time_three_outline,
	["04"] = wezterm.nerdfonts.md_clock_time_four_outline,
	["05"] = wezterm.nerdfonts.md_clock_time_five_outline,
	["06"] = wezterm.nerdfonts.md_clock_time_six_outline,
	["07"] = wezterm.nerdfonts.md_clock_time_seven_outline,
	["08"] = wezterm.nerdfonts.md_clock_time_eight_outline,
	["09"] = wezterm.nerdfonts.md_clock_time_nine_outline,
	["10"] = wezterm.nerdfonts.md_clock_time_ten_outline,
	["11"] = wezterm.nerdfonts.md_clock_time_eleven_outline,
	["12"] = wezterm.nerdfonts.md_clock_time_twelve, -- 12:00 in solid icon
	["13"] = wezterm.nerdfonts.md_clock_time_one, -- 1:00 in solid icon
	["14"] = wezterm.nerdfonts.md_clock_time_two, -- 2:00 in solid icon
	["15"] = wezterm.nerdfonts.md_clock_time_three, -- 3:00 in solid icon
	["16"] = wezterm.nerdfonts.md_clock_time_four, -- 4:00 in solid icon
	["17"] = wezterm.nerdfonts.md_clock_time_five, -- 5:00 in solid icon
	["18"] = wezterm.nerdfonts.md_clock_time_six, -- 6:00 in solid icon
	["19"] = wezterm.nerdfonts.md_clock_time_seven, -- 7:00 in solid icon
	["20"] = wezterm.nerdfonts.md_clock_time_eight, -- 8:00 in solid icon
	["21"] = wezterm.nerdfonts.md_clock_time_nine, -- 9:00 in solid icon
	["22"] = wezterm.nerdfonts.md_clock_time_ten, -- 10:00 in solid icon
	["23"] = wezterm.nerdfonts.md_clock_time_eleven, -- 11:00 in solid icon
}

M.font_maple = {
	{
		-- Font Family
		family = "Maple Mono NF",
		-- Font WeightLazy
		weight = "Medium",
		-- Character Varients and Ligatures
		harfbuzz_features = M.maple_features,
	},
	{
		-- Font Family
		family = "Iosevka Term",
		-- Font WeightLazy
		weight = "Medium",
		-- Character Varients and Ligatures
		harfbuzz_features = M.harfbuzz_features,
	},
	"Flog Symbols",
	"Symbols Nerd Font",
	"Symbols Nerd Font Mono",
	"Material Icons",
	"VictorMono Nerd Font",
	"Hack",
	"MonaspaceKrypton Nerd Font",
	"Roboto",
	"Cascadia Code",
}

M.font = {
	{
		-- Font Family
		family = "Iosevka Term",
		-- Font WeightLazy
		weight = "Regular",
		-- Character Varients and Ligatures
		harfbuzz_features = M.harfbuzz_features,
	},
	"Flog Symbols",
	"Symbols Nerd Font",
	"Symbols Nerd Font Mono",
	"PowerlineSymbols",
	"Material Icons",
	"VictorMono Nerd Font",
	"Hack",
	"MonaspaceKrypton Nerd Font",
	"Roboto",
	"Cascadia Code",
	"JetBrains Mono",
	"Fira Code",
	"Fira Code Retina",
	"Fira Code Nerd Font",
	"FiraCode Nerd Font",
}

M.rootiest_font = {
	"Iosevka Rootiest v2",
	"Iosevka Rootiest",
	{
		-- Font Family
		family = "Iosevka Custom",
		-- Font Weight
		weight = "Regular",
		-- Character Varients and Ligatures
		harfbuzz_features = M.harfbuzz_rootiest,
	},
	"Flog Symbols",
	"Symbols Nerd Font Mono",
	"Symbols Nerd Font",
	"PowerlineSymbols",
	"Material Icons",
	"Noto Color Emoji",
	"VictorMono Nerd Font",
	"Hack",
	"MonaspaceKrypton Nerd Font",
	"Roboto",
	"Cascadia Code",
	"JetBrains Mono",
	"Fira Code",
	"Fira Code Retina",
	"Fira Code Nerd Font",
	"FiraCode Nerd Font",
}

M.win_font = {
	-- Tab Font Family
	family = "Iosevka Rootiest",
	-- Tab Font Weight
	weight = "Medium",
	-- Character Varients and Ligatures
	harfbuzz_features = M.harfbuzz_features,
}

M.leader = {
	icon = "❯",
	on = "❮",
	off = "❯",
	padding = {
		left = " ",
		right = "",
	},
}

return M
