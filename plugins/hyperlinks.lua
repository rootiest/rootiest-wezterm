--          ╭─────────────────────────────────────────────────────────╮
--          │                       HYPERLINKS                        │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

-- Hyperlink Rules
CONFIG.hyperlink_rules = {
	-- Matches: a URL in parens: (URL)
	{
		regex = "\\((\\w+://\\S+)\\)",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in brackets: [URL]
	{
		regex = "\\[(\\w+://\\S+)\\]",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in curly braces: {URL}
	{
		regex = "\\{(\\w+://\\S+)\\}",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in angle brackets: <URL>
	{
		regex = "<(\\w+://\\S+)>",
		format = "$1",
		highlight = 1,
	},
	-- implicit mailto link
	{
		regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
		format = "mailto:$0",
	},
	-- Then handle URLs not wrapped in brackets
	{
		regex = "\\w+://[^\\s\\]})(]+",
		format = "$0",
	},
}

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
