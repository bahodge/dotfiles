-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- Leader is ctrl+space
config.leader = { key = 'Space', mods = 'CTRL|SHIFT' }

-- Appearance
config.color_scheme = 'Snazzy'
config.window_background_opacity = 0.98
config.hide_tab_bar_if_only_one_tab = true

config.keys = {

    -- Pane Seletion
    { key = 'h',          mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection "Left", },
    { key = 'l',          mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection "Right", },
    { key = 'k',          mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection "Up", },
    { key = 'j',          mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection "Down", },

    -- Pane Resize
    { key = 'LeftArrow',  mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'RightArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'UpArrow',    mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'DownArrow',  mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Down', 1 } },

    -- Tab Controls
    -- Create new Tab
    { key = 'n',          mods = 'CTRL|ALT',   action = act.SpawnTab 'CurrentPaneDomain', },

    -- Tab Seletion
    { key = 'h',          mods = 'CTRL|ALT',   action = act.ActivateTabRelative(-1) },
    { key = 'l',          mods = 'CTRL|ALT',   action = act.ActivateTabRelative(1) },

    -- Split Pane
    {
        key = 'h',
        mods = 'CTRL|SHIFT|ALT',
        action = act.SplitPane {
            direction = "Left",
            size = { Percent = 50 },
        }
    },
    {
        key = 'l',
        mods = 'CTRL|SHIFT|ALT',
        action = act.SplitPane {
            direction = "Right",
            size = { Percent = 50 },
        }
    },
    {
        key = 'k',
        mods = 'CTRL|SHIFT|ALT',
        action = act.SplitPane {
            direction = "Up",
            size = { Percent = 50 },
        }
    },
    {
        key = 'j',
        mods = 'CTRL|SHIFT|ALT',
        action = act.SplitPane {
            direction = "Down",
            size = { Percent = 50 },
        }
    },

    -- Resize Mode
    {
        key = 'r',
        mods = 'LEADER',
        action = act.ActivateKeyTable {
            name = 'resize_pane',
            one_shot = false,
            replace_current = true,
        }
    },
}

config.key_tables = {
    resize_pane = {
        { key = 'LeftArrow',  action = act.AdjustPaneSize { 'Left', 1 } },
        { key = 'h',          action = act.AdjustPaneSize { 'Left', 1 } },
        { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
        { key = 'l',          action = act.AdjustPaneSize { 'Right', 1 } },
        { key = 'UpArrow',    action = act.AdjustPaneSize { 'Up', 1 } },
        { key = 'k',          action = act.AdjustPaneSize { 'Up', 1 } },
        { key = 'DownArrow',  action = act.AdjustPaneSize { 'Down', 1 } },
        { key = 'j',          action = act.AdjustPaneSize { 'Down', 1 } },

        -- Cancel the mode by pressing escape
        { key = 'Escape',     action = 'PopKeyTable' },
    },
}

return config
