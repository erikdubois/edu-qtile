# qtile-kiro

The Kiro qtile configuration. A merge of two upstream configs:

- **Visual design** (DoomOne colour scheme, bar layout, widgets, circle GroupBox)
  comes from the DTOS / CachyOS qtile (`qtile`).
- **Keybindings are authoritative from `qtile-erik`**, and all of them are native
  qtile `Key()` bindings in [config.py](config.py) — window management, application
  launchers, multimedia, screenshots and wallpaper alike. qtile binds keys itself,
  so there is no sxhkd config to keep in sync.

## Design principle

> **What** (keys + the apps they launch) = qtile-erik, verbatim.
> **How it looks** (colours, borders, fonts, bar, widgets) = DTOS DoomOne.

## Layout

| Path | Source | Purpose |
|------|--------|---------|
| `config.py` | merged | qtile config: DTOS bar + every qtile-erik keybinding |
| `colors.py` | qtile (DTOS) | colour schemes; `DoomOne` is the active default |
| `scripts/` | qtile-erik | autostart.sh (trays, compositor, wallpaper), theme-switcher.sh |
| `rofi/` | qtile-erik | rofi launcher and colour-palette themes |
| `icons/` | qtile + qtile-erik | bar icon (`cachyos.svg`) + horizontal battery icons |
| `arcobattery.py` | qtile-erik | battery icon widget (available, not enabled by default) |

## Install

Deploy to `~/.config/qtile/`. On first start the `startup_once` hook runs
`scripts/autostart.sh`, which starts the trays, `fastcompmgr`, and the wallpaper.

## Notes / things to revisit

- App targets are kept **verbatim** from qtile-erik (vivaldi, archlinux-logout,
  variety, xfce4-*). Swap to Kiro equivalents later if needed.
- The DTOS emacs/dmscripts `KeyChord` menus were intentionally dropped (they collided
  with qtile-erik's `Super+e`=code and `Super+p`=wallpaper).
- Bar icon is still the DTOS `cachyos.svg`; replace with a Kiro logo when one exists.
- Validate on the target box with `qtile check` before shipping (qtile CLI was not
  available where this was assembled).
