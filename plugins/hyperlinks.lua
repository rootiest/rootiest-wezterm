--          ╭─────────────────────────────────────────────────────────╮
--          │                       HYPERLINKS                        │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

-- Hyperlink Rules
CONFIG.hyperlink_rules = WEZTERM.default_hyperlink_rules()

-- Add support for GitHub link style
table.insert(CONFIG.hyperlink_rules, {
	regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
	format = "https://www.github.com/$1/$3",
})

return M
