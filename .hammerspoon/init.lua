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

-- caffeinate menubar
local caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
	if state then
		caffeine:setIcon("caffeine-on.pdf")
	else
		caffeine:setIcon("caffeine-off.pdf")
	end
end

function caffeineClicked()
	setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
	caffeine:setClickCallback(caffeineClicked)
	setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

-- pause everything on mute
local muted = false
local state = ""
local volume = 0
hs.hotkey.bind({}, "F9", function()
	muted = not muted
	if muted then
		state = "'" .. hs.itunes.getPlaybackState() .. "'"
		volume = hs.audiodevice.current().volume
		hs.audiodevice.current().device:setVolume(0)
		alert("Muted")
		if state == hs.itunes.state_playing then 
			alert("iTunes paused")
			hs.itunes.pause()
		end
	else
		hs.audiodevice.current().device:setVolume(volume)
		alert("Unmuted")
		if state == hs.itunes.state_playing then
			alert("iTunes played")
			hs.itunes.play()
			state = ""
		end
	end
end)

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
-- center
hs.hotkey.bind({"cmd", "alt"}, "C", function()
	hs.window.focusedWindow():centerOnScreen()
end)
-- full
hs.hotkey.bind({"cmd", "alt"}, "F", function()
	hs.window.focusedWindow():moveToUnit(hs.geometry.rect(0, 0, 1, 1))
end)
-- left half
hs.hotkey.bind({"cmd", "alt", "shift"}, "Left", function()
	hs.window.focusedWindow():moveToUnit(hs.geometry.rect(0, 0, 0.5, 1))
end)
-- right half
hs.hotkey.bind({"cmd", "alt", "shift"}, "Right", function()
	hs.window.focusedWindow():moveToUnit(hs.geometry.rect(0.5, 0, 0.5, 1))
end)
-- left 2/3
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "Left", function()
	hs.window.focusedWindow():moveToUnit(hs.geometry.rect(0, 0, 2/3, 1))
end)
-- right 2/3
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "Right", function()
	hs.window.focusedWindow():moveToUnit(hs.geometry.rect(1/3, 0, 2/3, 1))
end)
-- top half
hs.hotkey.bind({"cmd", "alt", "shift"}, "Up", function()
	hs.window.focusedWindow():moveToUnit(hs.geometry.rect(0, 0, 1, 0.5))
end)
-- bottom half
hs.hotkey.bind({"cmd", "alt", "shift"}, "Down", function()
	hs.window.focusedWindow():moveToUnit(hs.geometry.rect(0, 0.5, 1, 0.5))
end)
-- top left
hs.hotkey.bind({"cmd", "ctrl"}, "Left", function()
	hs.window.focusedWindow():moveToUnit(hs.geometry.rect(0, 0, 0.5, 0.5))
end)
-- bottom left
hs.hotkey.bind({"cmd", "ctrl", "shift"}, "Left", function()
	hs.window.focusedWindow():moveToUnit(hs.geometry.rect(0, 0.5, 0.5, 0.5))
end)
-- top right
hs.hotkey.bind({"cmd", "ctrl"}, "Right", function()
	hs.window.focusedWindow():moveToUnit(hs.geometry.rect(0.5, 0, 0.5, 0.5))
end)
-- bottom right
hs.hotkey.bind({"cmd", "ctrl", "shift"}, "Right", function()
	hs.window.focusedWindow():moveToUnit(hs.geometry.rect(0.5, 0.5, 0.5, 0.5))
end)
-- 1 screen left
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
	hs.window.focusedWindow():moveOneScreenWest(false, true)
end)
-- 1 screen right
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
	hs.window.focusedWindow():moveOneScreenEast(false, true)
end)
-- 1 screen up
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", function()
	hs.window.focusedWindow():moveOneScreenNorth(false, true)
end)
-- 1 screen down
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Down", function()
	hs.window.focusedWindow():moveOneScreenSouth(false, true)
end)