-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'


----- this is the auto dark mode
-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return 'Dark'
end

local function scheme_autodark(appearance)
	if appearance:find 'Dark' then
		return 'Catppuccin Macchiato'
	else
		return 'Catppuccin Latte'
	end
end

local function active_titlebar_bg_autodark(appearance)
	if appearance:find 'Dark' then
		return "#332A1A"
	else
		return "#dEdEdE"
	end
end

local function inactive_tab_autodark(appearance)
	if appearance:find 'Dark' then
		return {
			bg_color = '#1b1032',
			fg_color = '#808080',
		}
	else
		return {
			bg_color = '#cccccc',
			fg_color = '#909090',
			italic = true,
		}
	end
end

local function active_tab_autodark(appearance)
	if appearance:find 'Dark' then
		return {
			bg_color = '#3b3052',
			fg_color = '#909090',
			italic = true,
		}
	else
		return {
			-- The color of the background area for the tab
			bg_color = '#eDeDeD',
			-- The color of the text for the tab
			fg_color = '#404040',
		}
	end
end


local function inactive_titlebar_bg_autodark(appearance)
	if appearance:find 'Dark' then
		return "#372f24"
	else
		return "#BBBBBB"
	end
end


----- auto dark ends here. Consider moving to helper file. Need to figure out the tab bar color

config.color_scheme = scheme_autodark(get_appearance())

config.window_frame = {
	-- The font used in the tab bar.
	-- Roboto Bold is the default; this font is bundled
	-- with wezterm.
	-- Whatever font is selected here, it will have the
	-- main font setting appended to it to pick up any
	-- fallback fonts you may have used there.
	font = wezterm.font { family = 'Atkinson Hyperlegible' },
	-- The size of the font in the tab bar.
	-- Default to 10. on Windows but 12.0 on other systems
	font_size = 12.0,
	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = active_titlebar_bg_autodark(get_appearance()),
	-- The overall background color of the tab bar when
	-- the window is not focused
	inactive_titlebar_bg = inactive_titlebar_bg_autodark(get_appearance()),
	-- active_tab_hover = {
	-- 	bg_color = '#3b3052',
	-- 	fg_color = '#909090',
	-- 	italic = true,
	-- }
}

config.colors = {
	tab_bar = {
		-- The color of the inactive tab bar edge/divider
		active_tab = active_tab_autodark(get_appearance()),
		inactive_tab = inactive_tab_autodark(get_appearance()),
		inactive_tab_hover = {
			bg_color = '#ddd',
			fg_color = '#909090',
			italic = true,
		},
		new_tab = inactive_tab_autodark(get_appearance()),
		new_tab_hover = {
			bg_color = '#eee',
			fg_color = '#909090',
			italic = true,
		},
	},
}

config.font = wezterm.font 'Hasklig'
config.font_size = 14
config.use_dead_keys = false
config.window_decorations = "RESIZE"

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- and finally, return the configuration to wezterm
return config
