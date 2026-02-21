local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

config.colors = {
    foreground = "#d5c4a1",
    background = "#282828",
    cursor_bg = "#ebdbb2",
    cursor_fg = "#282828",
    cursor_border = "#ebdbb2",
    selection_fg = "#d5c4a1",
    selection_bg = "#504945",

    ansi = {
        "#282828",
        "#fb4934",
        "#b8bb26",
        "#fabd2f",
        "#83a598",
        "#d3869b",
        "#8ec07c",
        "#d5c4a1",
    },
    brights = {
        "#665c54",
        "#fb4934",
        "#b8bb26",
        "#fabd2f",
        "#83a598",
        "#d3869b",
        "#8ec07c",
        "#fbf1c7",
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

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 13

config.window_padding = {
    left = 4,
    right = 4,
    top = 4,
    bottom = 4,
}

config.window_background_opacity = 0.90
config.window_decorations = "TITLE | RESIZE"

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.mouse_bindings = {
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "CTRL",
        action = act.OpenLinkAtMouseCursor,
    },
}

config.keys = {
    { key = "q", mods = "CTRL", action = act.ToggleFullScreen },
    { key = "'", mods = "CTRL", action = act.ClearScrollback("ScrollbackAndViewport") },
}

return config
