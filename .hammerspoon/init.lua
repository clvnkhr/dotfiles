-- myWatcher makes Hammerspoon autoreload configs when this file is modified.
function reloadConfig(files)
	doReload = false
	for _, file in pairs(files) do
		if file:sub(-4) == ".lua" then
			doReload = true
		end
	end
	if doReload then
		hs.reload()
	end
end

myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

-- simple helper function to print the current coordinates of the mouse
local function print_mouse_pos()
	print("mouse_pos")
	print(hs.inspect(hs.mouse.absolutePosition()))
end

local function print_attr_at_mouse_pos()
	local mouse_pos = hs.axuielement.systemElementAtPosition(hs.mouse.absolutePosition())
	print("attr_at_mouse_pos")
	print(hs.inspect(mouse_pos:allAttributeValues(true)))
end

local function relative(p1, p2)
	return hs.geometry.point(p1.x - p2.x, p1.y - p2.y)
end

local function absolute(x, y, origin)
	return hs.geometry.point(x + origin.x, y + origin.y)
end

local function print_ctrd_ui_coords_under_mouse()
	print("--------------------")
	hs.application.launchOrFocus("Texifier")
	-- local texifier = hs.appfinder.appFromName("Texifier")
	-- print(hs.inspect(texifier))
	hs.eventtap.keyStroke({ "cmd" }, ",")
	-- print(hs.inspect(hs.window.list(allWindows)))
	local prefs = hs.window.focusedWindow()
	-- local prefs_axui = hs.axuielement.windowElement(prefs)
	print("--------------------")
	print("running print_ctrd_ui_coords_under_mouse")
	print("--------------------")
	--print(hs.inspect(prefs_axui(actionNames()) -- useless?
	local tl = prefs:topLeft()
	local mouse_pos = hs.axuielement.systemElementAtPosition(hs.mouse.absolutePosition())
	local ui_coords_under_mouse = mouse_pos.AXPosition
	print(hs.inspect(relative(ui_coords_under_mouse, tl)))
end

local function toggle_texifier_darkmode()
	hs.application.launchOrFocus("Texifier")
	local texifier = hs.appfinder.appFromName("Texifier")
	hs.eventtap.keyStroke({ "cmd" }, ",")
	-- print(hs.inspect(hs.window.list(allWindows)))
	local prefs = hs.window.focusedWindow()
	local prefs_axui = hs.axuielement.windowElement(prefs)
	print("--------------------")
	print("running toggle")
	print("--------------------")
	local tl = prefs:topLeft()
	-- have added 10 to all coordinates below instead of e.g. computing the center,
	-- clicking on the corner exactly doesn't seem to work
	local btn_Editor_coord = absolute(464, 10, tl)
	local btn_EditorLookAndFeel_coord = absolute(362, 72, tl)
	local btn_SelectATheme_coord = absolute(240, 135, tl)
	--local btn_Editor = hs.axuielement.systemElementAtPosition(btn_Editor_pt)
	hs.eventtap.leftClick(btn_Editor_coord)
	hs.eventtap.leftClick(btn_EditorLookAndFeel_coord)
	hs.eventtap.leftClick(btn_SelectATheme_coord)
	local curr_theme = hs.axuielement.systemElementAtPosition(hs.mouse.absolutePosition()).AXTitle
	print(hs.inspect(curr_theme))
	if curr_theme == "Tomorrow Night" then
		hs.eventtap.keyStroke({}, "down")
		hs.eventtap.keyStroke({}, "down")
	else
		hs.eventtap.keyStroke({}, "up")
		hs.eventtap.keyStroke({}, "up")
	end
	hs.eventtap.keyStroke({}, "return")
	-- print(hs.inspect(prefs_attrvals))
	hs.eventtap.keyStroke({ "cmd" }, "W")
	-- end
end

local function focus_latex_editor()
	hs.application.launchOrFocus("sioyek")
	hs.application.launchOrFocus("WezTerm")
end

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "M", print_mouse_pos)
print("hotkey runs     print_mouse_pos")
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "A", print_attr_at_mouse_pos)
print("hotkey runs     print_attr_at_mouse_pos")
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "I", print_ctrd_ui_coords_under_mouse)
print("hotkey runs     print_ctrd_ui_coords_under_mouse")
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "T", toggle_texifier_darkmode)
print("hotkey runs toggle_texifier_darkmode")
hs.hotkey.bind({ "cmd", "alt" }, "tab", focus_latex_editor)
print("hotkey runs toggle_texifier_darkmode")
-- -- --------------------------------------------------------------------------
-- --
-- -- Implementation of a dark mode library for detecting and setting dark
-- -- mode in MacOS. https://github.com/Hammerspoon/hammerspoon/issues/2386
-- --
-- -- --------------------------------------------------------------------------
-- --
-- -- Example:
-- --
-- -- dm = require "darkmode"
-- -- dm.addHandler(function(dm2) print('darkmode changed:',dm2) end)
-- -- print('darkmode:',dm.getDarkMode())
-- -- dm.setDarkMode(not dm.getDarkMode())
-- -- print('darkmode:',dm.getDarkMode())
-- -- dm.setDarkMode(not dm.getDarkMode())
-- --
-- -- --------------------------------------------------------------------------
--
-- -- --------------------------------------------------------------------------
-- -- internal Data which should not be garbage collected
-- -- --------------------------------------------------------------------------
--
-- local internalData = {
-- 	darkmode = false,
-- 	watcher = nil,
-- 	handler = {}
-- }
--
-- -- --------------------------------------------------------------------------
-- -- General functions
-- -- --------------------------------------------------------------------------
--
-- local function getDarkModeFromSystem()
-- 	-- local _, darkmode = hs.osascript.applescript('tell application "System Events"\nreturn dark mode of appearance preferences\nend tell')
-- 	local _, darkmode = hs.osascript.javascript("Application('System Events').appearancePreferences.darkMode.get()")
-- 	return darkmode
-- end
--
-- local function getDarkMode()
-- 	return internalData.darkmode
-- end
--
-- local function setDarkMode(state)
-- 	hs.osascript.javascript(string.format("Application('System Events').appearancePreferences.darkMode.set(%s)",
-- 		state))
-- end
--
-- local function addHandler(fn)
-- 	-- add it here...
-- 	internalData.handler[#internalData.handler + 1] = fn
-- end
--
-- -- --------------------------------------------------------------------------
-- -- Internal functions
-- -- --------------------------------------------------------------------------
--
-- local function initialize()
-- 	internalData.darkmode = getDarkModeFromSystem()
-- end
--
-- local function initializeWatcher()
-- 	-- exit if already watching
-- 	if internalData.watcher ~= nil then return end
--
-- 	internalData.watcher = hs.distributednotifications.new(function(name, object, userInfo)
-- 		local hasDarkMode = getDarkModeFromSystem()
-- 		if hasDarkMode ~= internalData.darkmode then
-- 			internalData.darkmode = hasDarkMode
-- 			-- execute each handler with the darkmode as parameter (may change in future)
-- 			for index, fn in ipairs(internalData.handler) do
-- 				fn(hasDarkMode)
-- 			end
-- 		end
-- 	end, 'AppleInterfaceThemeChangedNotification')
--
-- 	internalData.watcher:start()
-- end
--
-- -- --------------------------------------------------------------------------
-- -- Initialization
-- -- --------------------------------------------------------------------------
--
-- initialize()
-- initializeWatcher()
--
-- local module = {
-- 	_ = internalData,
-- 	setDarkMode = setDarkMode,
-- 	getDarkMode = getDarkMode,
-- 	addHandler = addHandler
-- }
--
-- return module
--
