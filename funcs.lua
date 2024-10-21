--          ╭─────────────────────────────────────────────────────────╮
--          │                          FUNCS                          │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

local wezterm = WEZTERM
local types = require("types")

-- Update status event
wezterm.on("update-status", function(window, pane)
	-- Set the leader icon
	if window:leader_is_active() then
		types.leader.icon = types.leader.on
	else
		types.leader.icon = types.leader.off
	end

	-- Set the TERM
	local tty = pane:get_tty_name()
	if tty then
		CONFIG.term = "wezterm"
	else
		CONFIG.term = "xterm-256color"
	end
end)

---@function Function to render the leader icon
---@return string leadericon The leader icon
function M.leader_component()
	local prefix = types.leader.padding.left or types.leader.prefix or " "
	local suffix = types.leader.padding.right or types.leader.suffix or ""
	local leaderstr = prefix .. types.leader.icon .. suffix
	return leaderstr
end

---@function Function to convert a number to its ordinal string representation
---@param n string The number to convert
---@return string The ordinal string representation
function M.ordinal(n)
	local suffixes = { "th", "st", "nd", "rd" }
	local mod100 = n % 100
	return n .. (suffixes[(mod100 - 20) % 10 + 1] or suffixes[1])
end

---@function Function to format the tab title
---@param title string The original tab title
---@return string new_string Formatted string
function M.format_tab_title(title)
	if title ~= "default" then
		return title .. wezterm.nerdfonts.ple_right_half_circle_thin
	else
		return ""
	end
end

---@function Function to format the tab title
---@param title string The original tab title
---@return string new_string Formatted string
function M.format_inactive_tab_title(title)
	if title ~= "default" then
		return title .. " "
	else
		return ""
	end
end

---@function Function to convert an hour to an angle
---@param hour string The hour to convert
---@return number The angle in degrees
function M.get_hour_angle(hour)
	return (hour / 12) * 360
end

-- Function to convert a hex color to its opposite brightness
function M.invert_color_brightness(hex_color)
	-- Validate the input hex_color format
	if not hex_color:match("^#%x%x%x%x%x%x$") then
		error("Invalid hex color format. Use #RRGGBB.")
	end

	-- Remove the hash (#) from the hex color
	local r = tonumber(hex_color:sub(2, 3), 16) -- Red component
	local g = tonumber(hex_color:sub(4, 5), 16) -- Green component
	local b = tonumber(hex_color:sub(6, 7), 16) -- Blue component

	-- Check for valid RGB values before proceeding
	if not (r and g and b and r >= 0 and r <= 255 and g >= 0 and g <= 255 and b >= 0 and b <= 255) then
		error("Invalid RGB values extracted from hex color.")
	end

	-- Calculate the brightness of the color using perceived brightness formula
	local brightness = (r * 0.299 + g * 0.587 + b * 0.114)

	-- Invert the color based on brightness
	if brightness < 128 then
		-- If the color is dark, make it lighter
		r = math.min(r + (255 - r) * 0.33, 255)
		g = math.min(g + (255 - g) * 0.33, 255)
		b = math.min(b + (255 - b) * 0.33, 255)
	else
		-- If the color is light, make it darker
		r = math.max(r - r * 0.66, 0)
		g = math.max(g - g * 0.66, 0)
		b = math.max(b - b * 0.66, 0)
	end

	-- Convert back to hex format, ensuring components are integers
	return string.format("#%02x%02x%02x", math.floor(r + 0.5), math.floor(g + 0.5), math.floor(b + 0.5))
end

-- Function to get the complementary color of a given hex color
function M.complementary_color(hex_color)
	-- Validate the input hex_color format
	if not hex_color:match("^#%x%x%x%x%x%x$") then
		error("Invalid hex color format. Use #RRGGBB.")
	end

	-- Remove the hash (#) from the hex color and extract RGB components
	local r = tonumber(hex_color:sub(2, 3), 16) -- Red component
	local g = tonumber(hex_color:sub(4, 5), 16) -- Green component
	local b = tonumber(hex_color:sub(6, 7), 16) -- Blue component

	-- Calculate the complementary color by inverting the RGB components
	local complementary_r = 255 - r
	local complementary_g = 255 - g
	local complementary_b = 255 - b

	-- Convert the inverted RGB values back to hex format
	return string.format("#%02x%02x%02x", complementary_r, complementary_g, complementary_b)
end

return M
