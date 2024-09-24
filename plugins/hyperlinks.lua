--          ╭─────────────────────────────────────────────────────────╮
--          │                       HYPERLINKS                        │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

-- Hyperlink Rules
CONFIG.hyperlink_rules = WEZTERM.default_hyperlink_rules()

-- Add support for GitHub link style

table.insert(CONFIG.hyperlink_rules, {
	regex = [["([a-zA-Z0-9_\-]+/[a-zA-Z0-9_\-\.]+)"]],
	format = "https://www.github.com/$1",
	highlight = 1,
})

-- make Jira IDs clickable
table.insert(CONFIG.hyperlink_rules, {
	regex = [[\b([A-Z]+-\d+)\b]],
	format = "https://jira.YOUR_JIRA.com/browse/$1",
	highlight = 1,
})

return M
