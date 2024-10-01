--- Battery module for Wezterm.
---@module "battery"

---@class M The battery module
---@field invert boolean Whether to invert colors
---@function get_batteries() Get the list of batteries
---@function get_battery_icons() Get the battery icons
---@function get_battery_stats() Get the battery stats

local M = {}

local wezterm = require("wezterm")

--- Whether to invert the colors for light backgrounds.
M.invert = false

--- Converts a hex color to its opposite brightness.
---@param hex_color string The hex color in the format "#RRGGBB".
---@param invert? boolean Whether to invert the colors (optional).
---@return string hex_color The hex color with the opposite brightness.
local function invert_color_brightness(hex_color, invert)
	if invert == nil then
		invert = M.invert
	end
	if invert == false then
		return hex_color
	end
	-- Validate the input hex_color format.
	if not hex_color:match("^#%x%x%x%x%x%x$") then
		error("Invalid hex color format. Use #RRGGBB.")
	end

	-- Convert hex to RGB.
	local r = tonumber(hex_color:sub(2, 3), 16)
	local g = tonumber(hex_color:sub(4, 5), 16)
	local b = tonumber(hex_color:sub(6, 7), 16)

	-- Validate RGB values.
	if not (r and g and b and r >= 0 and r <= 255 and g >= 0 and g <= 255 and b >= 0 and b <= 255) then
		error("Invalid RGB values extracted from hex color.")
	end

	-- Calculate brightness.
	local brightness = (r * 0.299 + g * 0.587 + b * 0.114)

	-- Invert color based on brightness.
	if brightness < 128 then
		-- Dark color: make it lighter.
		r = math.min(r + (255 - r) * 0.33, 255)
		g = math.min(g + (255 - g) * 0.33, 255)
		b = math.min(b + (255 - b) * 0.33, 255)
	else
		-- Light color: make it darker.
		r = math.max(r - r * 0.66, 0)
		g = math.max(g - g * 0.66, 0)
		b = math.max(b - b * 0.66, 0)
	end

	-- Convert RGB back to hex.
	return string.format("#%02x%02x%02x", math.floor(r + 0.5), math.floor(g + 0.5), math.floor(b + 0.5))
end

--- RGBColor class representing an RGB color.
---@class RGBColor
---@field r number Red value (0-255).
---@field g number Green value (0-255).
---@field b number Blue value (0-255).

--- Blends two RGB colors together based on a blend factor.
---@param color1 RGBColor The first RGB color.
---@param color2 RGBColor The second RGB color.
---@param factor number The blend factor (between 0 and 1).
---@return RGBColor color The blended RGB color.
local function blend_color(color1, color2, factor)
	return {
		r = color1.r + (color2.r - color1.r) * factor,
		g = color1.g + (color2.g - color1.g) * factor,
		b = color1.b + (color2.b - color1.b) * factor,
	}
end

--- Rounds a decimal value to the nearest integer.
---@param val number The value to round.
---@return integer The rounded value.
local function round(val)
	return math.floor(val + 0.5)
end

--- Converts an RGB color to a hex string.
---@param color RGBColor The RGB color to convert.
---@return string hex_color The hex string representation of the color.
local function rgb_to_hex(color)
	return string.format("#%02x%02x%02x", round(color.r), round(color.g), round(color.b))
end

--- Gets the color representing a battery charge level.
---@param charge number The charge level (0.0 to 1.0).
---@return string hex_color The corresponding hex color.
local function get_charge_color(charge)
	local red = { r = 255, g = 0, b = 0 }
	local yellow = { r = 255, g = 255, b = 0 }
	local green = { r = 0, g = 255, b = 0 }
	local color = {}

	if charge <= 0.5 then
		local factor = charge / 0.5
		color = blend_color(red, yellow, factor)
	else
		local factor = (charge - 0.5) / 0.5
		color = blend_color(yellow, green, factor)
	end

	return invert_color_brightness(rgb_to_hex(color))
end

--- BatteryComponent class representing battery information.
---@class BatteryComponent
---@field battery string The battery icon and percentage. (e.g. "󰂉  100%")
---@field remaining fun(): string The remaining time as a string. (e.g. "10:00")
---@field icon string The icon representing the battery status. (e.g. "󰢜 ")
---@field percent number The battery percentage. (0.0 to 1.0)
---@field time number The remaining time in minutes.
---@field condition string The battery condition ("Full", "Empty", "Charging", "Discharging", "Unknown").

--- Returns battery components for each battery.
--- If no batteries are detected, an empty table is returned.
---@return BatteryComponent[] batteries A list of battery components.
---@see BatteryComponent
function M.get_batteries()
	local batteries = {}
	local battery_info = wezterm.battery_info()

	local icons_charging =
		{ "󰢟 ", "󰢜 ", "󰂆 ", "󰂇 ", "󰂈 ", "󰢝 ", "󰂉 ", "󰢞 ", "󰂊 ", "󰂋 ", "󰂅 " }
	local icons_discharging =
		{ "󰂎 ", "󰁺 ", "󰁻 ", "󰁼 ", "󰁽 ", "󰁾 ", "󰁿 ", "󰂀 ", "󰂁 ", "󰂂 ", "󰁹 " }

	for _, b in ipairs(battery_info) do
		local condition = b.state
		local charge = b.state_of_charge
		local remaining = 0
		local percent = charge * 100
		local icon = -- Default battery state is Unknown
			wezterm.format({ { Foreground = { Color = invert_color_brightness("#232634") } }, { Text = "󰂑 " } })

		if condition == "Full" then -- Battery is 100% charged
			icon =
				wezterm.format({ { Foreground = { Color = invert_color_brightness("#93e398") } }, { Text = "󰁹 " } })
		elseif condition == "Empty" then -- Battery is 0% charged
			icon =
				wezterm.format({ { Foreground = { Color = invert_color_brightness("#f37ca0") } }, { Text = "󱃍 " } })
		elseif condition == "Charging" then -- Battery is charging
			remaining = b.time_to_full
			icon = wezterm.format({
				{ Foreground = { Color = get_charge_color(charge) } },
				{ Text = icons_charging[math.min(math.ceil(charge * 10), 11)] },
			})
		elseif condition == "Discharging" then -- Battery is discharging
			remaining = b.time_to_empty
			icon = wezterm.format({
				{ Foreground = { Color = get_charge_color(charge) } },
				{ Text = icons_discharging[math.min(math.ceil(charge * 10), 11)] },
			})
		elseif condition == "Unknown" and charge > 0.5 then -- Battery is (probably) at charge limit
			icon =
				wezterm.format({ { Foreground = { Color = invert_color_brightness("#93e398") } }, { Text = "󱈑 " } })
		end

		table.insert(batteries, {
			battery = icon .. string.format("%.2f%%", percent),
			remaining = function()
				if remaining and remaining > 0 then
					return string.format("%d:%02d", math.floor(remaining / 60), math.floor(remaining % 60))
				else
					return ""
				end
			end,
			icon = icon,
			percent = percent,
			time = remaining,
			condition = condition,
		})
	end

	return batteries
end

--- Returns battery icons for all batteries.
--- If no batteries are detected, an empty string is returned.
---@return string battery_icons A formatted string containing the battery icons.
function M.get_battery_icons()
	local battery_states = M.get_batteries()

	if #battery_states == 0 then
		return ""
	end

	local result = {}
	for _, state in ipairs(battery_states) do
		table.insert(result, state.icon)
	end

	return table.concat(result, " | ")
end

--- Returns battery statistics for all batteries.
--- If no batteries are detected, an empty string is returned.
---@return string battery_stats A formatted string containing the battery stats.
function M.get_battery_stats()
	local battery_states = M.get_batteries()

	if #battery_states == 0 then
		return ""
	end

	local result = {}
	for _, state in ipairs(battery_states) do
		local color = get_charge_color(state.percent / 100)
		local percent = wezterm.format({
			{ Foreground = { Color = color } },
			{ Text = string.format(" (%.2f%%)", state.percent) },
		})
		local remaining_time = wezterm.format({
			{ Foreground = { Color = color } },
			{ Text = state.remaining() },
		})
		table.insert(result, string.format("%s%s", state.icon, percent) .. remaining_time)
	end

	return table.concat(result, " | ")
end

return M
