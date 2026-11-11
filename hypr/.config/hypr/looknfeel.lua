-- Personal appearance overrides. Omarchy supplies the remaining defaults.
hl.config({
  cursor = {
    hide_on_key_press = false,
  },
  general = {
    gaps_in = 0,
    gaps_out = 0,
    border_size = 1,
  },
  decoration = {
    rounding = 5,
    -- Hyprland accepts opacity only from 0 through 1; the previous 2.0 value
    -- is represented by its intended fully-opaque value.
    active_opacity = 1,
    inactive_opacity = 1,
    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = "rgba(1a1a1aee)",
    },
    blur = {
      enabled = true,
      size = 3,
      passes = 1,
      vibrancy = 0.1696,
    },
  },
  misc = {
    force_default_wallpaper = 1,
    disable_hyprland_logo = false,
  },
})

-- Keep Omarchy's extra animation definitions while applying the custom speeds.
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-- Opt another application in to Omarchy's standard transparency.
-- Find its class with: hyprctl clients
-- o.transparent_window("my-app")
-- o.transparent_window("my-app", "0.9 0.85") -- Custom active/inactive opacity.
