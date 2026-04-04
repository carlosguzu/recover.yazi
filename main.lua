-- ~/.config/yazi/plugins/recover.yazi/main.lua


local function url_decode(str)
	if not str then return nil end
	str = string.gsub(str, "%%(%x%x)", function(h)
		return string.char(tonumber(h, 16))
	end)
	return str
end

local get_state = ya.sync(function()
	local tab = cx.active
	if not tab or not tab.current then return nil end

	return {
		cwd = tostring(tab.current.cwd),
		hovered = tab.current.hovered and tostring(tab.current.hovered.url) or nil,
		hovered_name = tab.current.hovered and tab.current.hovered.name or nil
	}
end)

local function entry()
	local state = get_state()
	if not state then return end

	
	if not state.cwd:match(".*/Trash/files$") then
		return ya.notify {
			title = "Recover",
			content = "You are not in the Trash folder",
			timeout = 3,
			level = "warn",
		}
	end

	if not state.hovered then return end

	local url = state.hovered
	local name = state.hovered_name

	
	
	local info_dir = state.cwd:gsub("/files$", "/info")
	local info_file = info_dir .. "/" .. name .. ".trashinfo"

	
	local f = io.open(info_file, "r")
	if not f then
		return ya.notify {
			title = "Error",
			content = "No .trashinfo found for this file.",
			timeout = 3,
			level = "error",
		}
	end
	
	local content = f:read("*all")
	f:close()

	
	local raw_path = content:match("Path=([^\r\n]+)")
	if not raw_path then
		return ya.notify {
			title = "Error",
			content = "Could not parse original path.",
			timeout = 3,
			level = "error",
		}
	end

	
	local dest = url_decode(raw_path)

	local dest_without_filename = dest:match("^(.*)/")
	
	local yes = ya.confirm {
		pos = { "center", w = 70, h = 10 },
		title = "Recover File?",
		body = ui.Text("Restore '" .. name .. "' to:\n" .. dest_without_filename):wrap(ui.Wrap.YES),
	}

	if yes then
		
		local success, err = os.rename(url, dest)

		if success then
			
			os.remove(info_file)

			ya.notify {
				title = "Recovered",
				content = "File restored to original location",
				timeout = 3,
				level = "info",
			}
		else
			ya.notify {
				title = "Error",
				content = "Failed to recover: " .. tostring(err),
				timeout = 5,
				level = "error",
			}
		end
	end
end

return { entry = entry }
