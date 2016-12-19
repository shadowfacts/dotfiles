-- global helpers
-- key modifiers
cmd = "⌘"
ctrl = "⌃"
alt = "⌥"
shift = "⇧"

-- utility functions
function alert(msg)
	hs.alert.show(msg)
end

function notify(title, subtext)
	hs.notify.new({title=title, informativeText=subtext}):send()
end

-- automatic configuration reloading
function reloadConfig(files)
	local doReload = false
	for _, file in pairs(files) do
		if file:sub(-4) == ".lua" then
			doReload = true
			break
		end
	end
	if doReload then
		hs.reload()
		notify("Hammerspoon", "Configuration reloaded")
	end
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

-- layout all configured applications
local display = {
	cinema = "LED Cinema Display",
	dell = "DELL SE2416H"
}
local layout = {
	{"Google Chrome",		nil, 	display.dell,	hs.layout.maximized, 			nil,	nil},
	{"Google Chrome Canary",nil, 	display.dell,	hs.layout.maximized, 			nil,	nil},
	{"Textual IRC Client", 	nil, 	display.dell,	hs.geometry.rect(0, 0, 2/3, 1),	nil,	nil},
	{"Hexchat", 			nil, 	display.dell,	hs.geometry.rect(0, 0, 2/3, 1),	nil,	nil},
	{"Discord", 			nil,	display.dell,	hs.layout.right50, 				nil,	nil},
	{"Sublime Text",		nil,	display.cinema,	hs.layout.right50,				nil,	nil},
	{"IntelliJ IDEA-EAP",	nil,	display.cinema, hs.layout.maximized,			nil,	nil}
}

hs.hotkey.bind({"cmd", "alt"}, "L", function()
	hs.layout.apply(layout)
end)

-- window movement
local padding = 20
-- center
hs.hotkey.bind({"cmd", "alt"}, "C", function()
	hs.window.focusedWindow():centerOnScreen(0)
end)
-- full
hs.hotkey.bind({"cmd", "alt"}, "F", function()
	local window = hs.window.focusedWindow()
	local screen = window:screen()
	local frame = screen:frame()
	frame.x = frame.x + padding
	frame.y = frame.y + padding
	frame.w = frame.w - padding * 2
	frame.h = frame.h - padding * 2
	window:setFrame(frame, 0)
end)
-- left half of current
hs.hotkey.bind({"cmd", "alt", "shift"}, "Left", function()
	local window = hs.window.focusedWindow()
	local frame = window:frame()
	frame.w = (frame.w / 2) - padding / 2
	window:setFrame(frame, 0)
end)
-- right half
hs.hotkey.bind({"cmd", "alt", "shift"}, "Right", function()
	local window = hs.window.focusedWindow()
	local frame = window:frame()
	frame.w = (frame.w - padding) / 2
	frame.x = frame.x + frame.w + padding
	window:setFrame(frame, 0)
end)
-- top half
hs.hotkey.bind({"cmd", "alt", "shift"}, "Up", function()
	local window = hs.window.focusedWindow()
	local frame = window:frame()
	frame.h = (frame.h / 2) - padding / 2
	window:setFrame(frame, 0)
end)
-- bottom half
hs.hotkey.bind({"cmd", "alt", "shift"}, "Down", function()
	local window = hs.window.focusedWindow()
	local frame = window:frame()
	frame.h = (frame.h - padding) / 2
	frame.y = frame.y + frame.h + padding
	window:setFrame(frame, 0)
end)
-- left by half
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
	local window = hs.window.focusedWindow()
	local frame = window:frame()
	frame.x = frame.x - (frame.w + padding) / 2
	window:setFrame(frame, 0)
end)
-- right by half
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
	local window = hs.window.focusedWindow()
	local frame = window:frame()
	frame.x = frame.x + (frame.w + padding) / 2
	window:setFrame(frame, 0)
end)
-- up by half
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", function()
	local window = hs.window.focusedWindow()
	local frame = window:frame()
	frame.y = frame.y - (frame.h + padding) / 2
	window:setFrame(frame, 0)
end)
-- down by half
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Down", function()
	local window = hs.window.focusedWindow()
	local frame = window:frame()
	frame.y = frame.y + (frame.h + padding) / 2
	window:setFrame(frame, 0)
end)


-- 1 screen left
-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
-- 	hs.window.focusedWindow():moveOneScreenWest(true, true)
-- end)
-- -- 1 screen right
-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
-- 	hs.window.focusedWindow():moveOneScreenEast(true, true)
-- end)

-- Googler
-- hs.hotkey.bind({"cmd", "alt"}, "g", function()
-- 	local ENDPOINT = "https://www.googleapis.com/customsearch/v1?cx=007161902339625765643%3Ab8i_gdvz0-s&key=AIzaSyDbY6r2Qk-KQ15jUXSnl8_66eZupqw_2q4&q="
	
-- 	local chooser = hs.chooser.new(function(chosen)
-- 		hs.execute("open "..chosen.subText)
-- 	end)

-- 	local theData = {}

-- 	function update()
-- 		if theData["items"] ~= nil then
-- 		local choices = hs.fnutils.imap(theData["items"], function(item)
-- 			return {
-- 				["text"] = item["title"],
-- 				["subText"] = item["link"],
-- 			}
-- 		end)

-- 		chooser:choices(choices)
-- 	end

-- 	local timer = hs.timer.new(3, update)

-- 	chooser:queryChangedCallback(function(string)
-- 		local query = hs.http.encodeForQuery(string)

-- 		hs.http.asyncGet(ENDPOINT..query, nil, function(status, data)
-- 			if not data then return end
-- 			local ok, results = pcall(function() return hs.json.decode(data) end)
-- 			if not ok then return end

-- 			theData = data
-- 			timer:setNextTrigger(3)
-- 		end)
-- 	end)

-- 	chooser:searchSubText(false)
-- 	chooser:show()
-- end)