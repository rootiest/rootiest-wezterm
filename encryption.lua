--          ╭─────────────────────────────────────────────────────────╮
--          │                       ENCRYPTION                        │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

-- Set the keyfile
local key = WEZTERM.home_dir .. "/.config/.private/key.txt"
local pubkey = "age1q80h5jsp9d48kggf9kra82xkgyaqdnehqenm003ftapem9re7ytqp9hr6h"

if MYKEY then
	key = MYKEY
elseif MYOS == "win" then
	key = WEZTERM.home_dir .. "\\.config\\.private\\key.txt"
end

if MYPUBKEY then
	pubkey = MYPUBKEY
else
end

---@function Check if a file exists
---@param file string The file path to check
---@return boolean exists True if the file exists, false otherwise
local function file_exists(file)
	local f = io.open(file, "r")
	if f then
		f:close()
		return true
	end
	return false
end

if file_exists(key) then
	RESURRECT.state_manager.set_encryption({
		enable = true,
		method = "age", -- "age" is the default encryption method, but you can also specify "rage" or "gpg"
		private_key = key, -- if using "gpg", you can omit this
		public_key = pubkey,
	})
end

return M
