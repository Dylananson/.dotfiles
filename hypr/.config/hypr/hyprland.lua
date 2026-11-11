-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
-- omarchy_default_bindings = false
--
-- Or disable only bindings for Omarchy's preinstalled apps/web apps while
-- keeping core window-manager bindings:
-- omarchy_preinstalled_bindings = false

-- Load Omarchy defaults.
require("default.hypr.omarchy")

-- Put your personal overrides in these files. They're loaded after Omarchy's
-- defaults so package updates can improve the defaults without rewriting your
-- ~/.config/hypr files.
require("hypr.monitors")
require("hypr.input")
require("hypr.looknfeel")
require("hypr.autostart")

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- Load keybinding overrides last so dynamic Omarchy state cannot restore a
-- default binding that a personal binding replaces.
require("hypr.bindings")

-- Add any other personal Hyprland configuration below.
-- Agent/taskboard demos and clip recordings launch the game with `--no-focus`,
-- which appends " (background)" to the title. They open on visible workspace 3
-- but never take focus or switch the workspace away from whatever the lead is
-- doing. Do not drop `silent`: a plain workspace rule follows the window.
o.window({ title = "Ashen Kingdom .* \\(background\\)$" }, {
  workspace = "3 silent",
  no_initial_focus = true,
})

-- A hand-launched game opens on ws 3 but never yanks the lead there or takes
-- focus. Switch to ws 3 and click it when ready to play.
o.window({ class = "^Ashen Kingdom - Prototype 001$" }, {
  workspace = "3 silent",
  no_initial_focus = true,
})
