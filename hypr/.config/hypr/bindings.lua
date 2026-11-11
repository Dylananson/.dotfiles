-- Personal bindings migrated from the former hyprland.custom.conf.
-- These unbinds intentionally replace the corresponding Omarchy bindings.
hl.unbind("SUPER + W")
hl.unbind("SUPER + V")
hl.unbind("SUPER + F")
hl.unbind("SUPER + J")
hl.unbind("SUPER + L")
hl.unbind("SUPER + S")
hl.unbind("SUPER + ALT + S")
hl.unbind("SUPER + SHIFT + S")
-- Omarchy's default on this chord is Calculator. Re-binding it below added a
-- second action instead of replacing that one, so every close also launched
-- omacalc. Unbind first so the chord closes windows and nothing else.
hl.unbind("SUPER + SHIFT + Q")

o.bind("SUPER + M", "Exit Hyprland", hl.dsp.exit())
o.bind("SUPER + SHIFT + Q", "Close window", hl.dsp.window.close())
o.bind("SUPER + E", "File manager", { omarchy = "nautilus" })
o.bind("SUPER + V", "Toggle window floating/tiling", hl.dsp.window.float({ action = "toggle" }))
o.bind("SUPER + R", "Omarchy menu", "omarchy-menu toggle root")
o.bind("SUPER + SHIFT + R", "Reload Hyprland", "hyprctl reload")
o.bind("SUPER + F", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

o.bind("SUPER + H", "Focus left", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + L", "Focus right", hl.dsp.focus({ direction = "r" }))
o.bind("SUPER + J", "Focus above", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + K", "Focus below", hl.dsp.focus({ direction = "d" }))

o.bind("SUPER + S", "Toggle scratchpad", hl.dsp.workspace.toggle_special("magic"))
o.bind("SUPER + SHIFT + S", "Move window to scratchpad", hl.dsp.window.move({ workspace = "special:magic" }))
