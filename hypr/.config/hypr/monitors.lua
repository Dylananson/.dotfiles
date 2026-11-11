-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

-- 27" 1080p ASUS VG279 on DP-2: 1x, native 1920x1080@144.
local omarchy_gdk_scale = 1

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))

-- No catch-all (`output = ""`) rule on purpose.
-- On this NVIDIA driver "preferred" resolves to 1680x1050@60, and the
-- catch-all is re-applied whenever DP-2 reappears after a link drop, which
-- overrides the explicit mode below. With a single panel there is nothing for
-- a catch-all to cover.
local function pin_display()
  hl.monitor({ output = "DP-2", mode = "1920x1080@144", position = "0x0", scale = 1 })
end

pin_display()

-- A DP link drop (or a shell/DPMS event that re-adds the output) lands on
-- Hyprland's default mode. Re-pin once Hyprland has finished its own setup.
hl.on("monitor.added", function(monitor)
  if monitor and monitor.name == "DP-2" then
    hl.timer(pin_display, { type = "oneshot", timeout = 1 })
  end
end)

-- Configure a specific monitor.
-- hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = 1 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })
