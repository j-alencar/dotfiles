local wezterm = require("wezterm")
local config = wezterm.config_builder()

local ok, wal_colors = pcall(dofile, os.getenv("HOME") .. "/.cache/wal/colors-wezterm.lua")
if ok and wal_colors then
    config.colors = wal_colors
else
    config.colors = {
        foreground = "#ebdbb2",
        background = "#282828",
        cursor_bg = "#ebdbb2",
        cursor_fg = "#282828",
        cursor_border = "#ebdbb2",
        selection_fg = "#282828",
        selection_bg = "#ebdbb2",

        ansi = {
            "#282828",
            "#cc241d",
            "#98971a",
            "#d79921",
            "#458588",
            "#b16286",
            "#689d6a",
            "#a89984",
        },
        brights = {
            "#928374",
            "#fb4934",
            "#b8bb26",
            "#fabd2f",
            "#83a598",
            "#d3869b",
            "#8ec07c",
            "#ebdbb2",
        },

        tab_bar = {
            background = "#282828",
            active_tab = {
                bg_color = "#282828",
                fg_color = "#b8bb26",
                intensity = "Bold",
            },
            inactive_tab = {
                bg_color = "#282828",
                fg_color = "#928374",
            },
            inactive_tab_hover = {
                bg_color = "#3c3836",
                fg_color = "#ebdbb2",
            },
            new_tab = {
                bg_color = "#282828",
                fg_color = "#928374",
            },
            new_tab_hover = {
                bg_color = "#3c3836",
                fg_color = "#ebdbb2",
            },
        },
    }
end

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 13

config.window_padding = {
    left = 4,
    right = 4,
    top = 4,
    bottom = 4,
}

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

return config
