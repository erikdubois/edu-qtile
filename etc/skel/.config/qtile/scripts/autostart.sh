#!/bin/bash
# =============================================================================
# autostart.sh — qtile (Wayland) session startup script
#
# Called BY qtile from the startup hook in config.py (not by the display
# manager directly), so it has NO window-manager loop — it just starts the
# background services and exits. qtile is the Wayland compositor itself, so
# there is no external compositor (picom) and no xrandr screen layout here.
#
# To autostart your own apps, add:  run "your-app"
# To stop an autostart entry, comment it out with #
# =============================================================================

# run() — start a program only if it is not already running.
# Exact-match (-x) on the 15-char process comm name avoids false "already up"
# hits from loose substring matching.
run() {
  if ! pgrep -x "$(basename "$1" | head -c 15)" >/dev/null; then
    "$@" &
  fi
}

# ── System tray applets ───────────────────────────────────────────────────────
run nm-applet                                        # NetworkManager wifi/eth tray
run pamac-tray                                       # Arch package manager tray
run xfce4-power-manager                              # Battery / display power management
run blueberry-tray                                   # Bluetooth manager tray
run /usr/lib/xfce4/notifyd/xfce4-notifyd             # Desktop notification daemon
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1  # Polkit auth popups (sudo GUI)

# ── Volume control ────────────────────────────────────────────────────────────
run volctl                                           # PipeWire/PulseAudio volume tray

# ── Wallpaper ─────────────────────────────────────────────────────────────────
# swaybg is the wlroots layer-shell wallpaper tool (feh is X11-only and does not
# work on Wayland). Sets the default Kiro wallpaper, scaled to fill.
run swaybg -i /usr/share/backgrounds/kiro/kiro-wallpaper.jpg -m fill
