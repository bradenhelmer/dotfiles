local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- Appearance Config
config.adjust_window_size_when_changing_font_size = false
config.color_scheme = 'Vs Code Dark+ (Gogh)'
-- config.color_scheme = 'Dissonance (Gogh)'
config.colors = {
	tab_bar = {
	}
}
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 24
config.font = wezterm.font 'DroidSansM Nerd Font'
config.font_size = 12
config.warn_about_missing_glyphs = false
config.initial_cols = 96
config.initial_rows = 24
config.window_decorations = "TITLE|RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0
}

-- Multiplexer Config
config.leader = { key = '`', timeout_milliseconds = 500 }
config.keys = {
	-- New Tab
	{
		mods = "LEADER",
		key = 'N',
		action = act.SpawnTab 'CurrentPaneDomain',
	},
	{
		mods = "LEADER",
		key = 'c',
		action = act.SpawnTab 'CurrentPaneDomain',
	},
	-- Splits Pane V | H
	{
		mods = "LEADER|SHIFT",
		key = '%',
		action = act.SplitVertical { domain = 'CurrentPaneDomain' },
	},
	{
		mods = "LEADER|SHIFT",
		key = '"',
		action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
	},
	-- Navigation
	{
		key = 'h',
		mods = 'LEADER',
		action = act.ActivatePaneDirection 'Left',
	},
	{
		key = 'j',
		mods = 'LEADER',
		action = act.ActivatePaneDirection 'Down',
	},
	{
		key = 'k',
		mods = 'LEADER',
		action = act.ActivatePaneDirection 'Up',
	},
	{
		key = 'l',
		mods = 'LEADER',
		action = act.ActivatePaneDirection 'Right',
	},
	{
		key = 'n',
		mods = 'LEADER',
		action = act.ActivateTabRelative(1)
	},
	{
		key = 'p',
		mods = 'LEADER',
		action = act.ActivateTabRelative(-1)
	},
	{
		key = 'w',
		mods = 'LEADER',
		action = act.ShowLauncherArgs { flags = 'TABS|WORKSPACES' }
	},
	{
		key = '`',
		mods = 'LEADER',
		action = act.ActivateLastTab
	},
	-- Resize
	{
		key = 'H',
		mods = 'LEADER',
		action = act.AdjustPaneSize { 'Left', 5 }
	},
	{
		key = 'J',
		mods = 'LEADER',
		action = act.AdjustPaneSize { 'Down', 5 }
	},
	{
		key = 'K',
		mods = 'LEADER',
		action = act.AdjustPaneSize { 'Up', 5 }
	},
	{
		key = 'L',
		mods = 'LEADER',
		action = act.AdjustPaneSize { 'Right', 5 }
	},
	-- Kill Tab
	{
		key = 'x',
		mods = 'LEADER',
		action = act.CloseCurrentTab { confirm = true }
	},
	-- Send tick
	{
		key = '`',
		mods = 'CTRL',
		action = act.SendString '`'
	}
}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = 'LEADER',
		action = act.ActivateTab(i-1)
	})
end

return config
