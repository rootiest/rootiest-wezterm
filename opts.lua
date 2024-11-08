--          ╭─────────────────────────────────────────────────────────╮
--          │                         CONFIG                          │
--          ╰─────────────────────────────────────────────────────────╯

local opts = {}

-- Function to merge tables into opts
local function merge_into_opts(mod)
	for k, v in pairs(require("config." .. mod)) do
		opts[k] = v
	end
end

-- List of default config modules to merge
local modules = {
	"colors",
	"font",
	"keys",
	"window",
	"platform",
}

-- Merge all default modules into opts
for _, mod in ipairs(modules) do
	merge_into_opts(mod)
end

-- If USERCONFIG is true, merge userconfig into opts
if USERCONFIG then
	for k, v in pairs(require("user")) do
		opts[k] = v
	end
else
	MYKEY = nil
	MYPUBKEY = nil
	MYTABLINE = nil
end

-- Return config options table
return opts
