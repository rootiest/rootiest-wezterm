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

-- List of config modules to merge
local modules = {
	"colors",
	"font",
	"keys",
	"window",
	"platform",
}

-- If USERCONFIG is true, merge userconfig
if USERCONFIG then
	merge_into_opts("user")
end

-- Merge all modules into opts
for _, mod in ipairs(modules) do
	merge_into_opts(mod)
end

-- Return config options
return opts
