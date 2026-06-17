<p align="center">
  <img src="kiro.jpg" alt="Kiro" width="220" />
</p>

# kiro-qtile-wayland

Educational / tutorial repository for [Qtile](https://qtile.org/) on **Wayland** — Qtile is a fully-Python tiling window manager, configurable and extensible in Python, that ships its own wlroots-based Wayland compositor. This is the Wayland variant of [`kiro-qtile`](https://github.com/kirodubes/kiro-qtile) (X11). Part of the `~/EDU/` learning series.

## What's in this repo

- `etc/skel/` — Qtile user config that lands in `/etc/skel/`.
- `setup.sh`, `up.sh`, `cleanup.sh` — standard EDU bash scaffold.

On Wayland, Qtile *is* the compositor — there is no external compositor (picom) and no sxhkd. All keybindings are native Qtile `Key()` bindings in `config.py`; screenshots use `grim` + `slurp`, brightness uses `brightnessctl`, and the wallpaper is set with `swaybg`.

## Keybindings

Press **`Super + Ctrl + S`** to open the searchable **kiro-keybindings** cheatsheet — an on-screen, type-to-filter list of every shortcut, identical across all Kiro desktops. The full list also ships as a plain-text [`keybindings.txt`](etc/skel/.config/qtile/keybindings.txt) in the config directory.

## Installation

### From `nemesis_repo` (recommended)

```ini
[nemesis_repo]
SigLevel = Never
Server = https://erikdubois.github.io/$repo/$arch
```

```bash
sudo pacman -Syu
sudo pacman -S kiro-qtile-wayland
```

You'll also need Qtile with its Wayland backend and the Wayland helper tools this config calls:

```bash
sudo pacman -S qtile grim slurp swaybg brightnessctl
```

### Manual

```bash
git clone https://github.com/kirodubes/kiro-qtile-wayland.git
cd kiro-qtile-wayland
sudo cp -r etc/skel/. /etc/skel/
```

Existing users can pull the config into their own home:

```bash
cp -rT /etc/skel ~/
```

## Websites

Information : https://erikdubois.be

## Social Media

Youtube : https://www.youtube.com/erikdubois

<!-- KIRO-FUNDING-FOOTER:START — managed by Kiro-HQ/cascade-readme-footer.sh -->
## Help fund Kiro

Everything I build here stays free and open — always. If Kiro or any of these
tools have ever saved you time or taught you something, a small monthly
contribution helps keep the work going. Donations target break-even, nothing
more — the core always stays free for everyone.

- GitHub Sponsors: https://github.com/sponsors/erikdubois
- Patreon: https://www.patreon.com/c/kiroproject
- YouTube memberships: https://www.youtube.com/@ErikDubois/join
- Ko-fi: https://ko-fi.com/erikdubois
- PayPal: https://www.paypal.me/erikdubois
<!-- KIRO-FUNDING-FOOTER:END -->

## License

See [LICENSE](./LICENSE).
