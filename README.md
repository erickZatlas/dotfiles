# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## What's included

### Shell
- `.bashrc` - Bash shell configuration
- `bash/` - Modular bash configuration:
  - `.aliases.sh` - Shell aliases (exa, clipboard, tool launchers)
  - `.exports.sh` - Environment variables, PATH, and 1Password secrets integration
  - `.functions.sh` - Loader for modular function files
  - `.bash_functions/` - Function modules (Datadog, process tools, search)
  - `.claude/` - Claude Code project settings
  - `CLAUDE.md` - Claude Code context for the bash config

### Dev tools
- `.gitconfig` - Git configuration with aliases and LFS setup
- `.ideavimrc` - IdeaVim plugin configuration for IntelliJ IDEA
- `.wezterm.lua` - WezTerm terminal configuration

### i3 Window Manager
Central configs and recovery scripts for a bulletproof i3 setup:

- `i3/config` — main keybindings, workspaces, appearance
- `i3/postswitch.sh` — unified monitor change handler (compositor, polybar, keyboard, cursor, wallpaper)
- `i3/fix-keyboard.sh` — re-applies `br,us` layout with Alt+Shift toggle
- `i3/flatten.sh` — flattens the current workspace (resets container nesting)
- `i3/center-mouse.sh` — warps mouse to focused window center on keyboard focus
- `i3/gather-workspaces.sh` — gathers all workspaces to the current monitor (after unplug)
- `i3/move-workspace.sh` — moves current workspace between monitors with compositor restart (prevents ghosting)
- `i3status/config` — fallback status bar config (polybar is primary)

### Polybar
- `polybar/config.ini` — Tokyo Night themed status bar with PipeWire/battery/wifi/layout modules
- `polybar/launch.sh` — multi-monitor launch script with timeout and fallback
- `polybar/layout.sh` — shows current container layout (H-Split, V-Split, Tabbed, Stacked)

### Compositor
- `picom/picom.conf` — kept for reference. Currently using xcompmgr (lighter on Intel Raptor Lake iGPU)

### Application Launcher
- `rofi/config.rasi` — Tokyo Night themed Rofi launcher

### Notifications
- `dunst/dunstrc` — Tokyo Night themed notification daemon

### Monitor Management (autorandr)
Three profiles with symlinked postswitch scripts (all point to `i3/postswitch.sh`):
- `autorandr/mobile/` — laptop only (eDP-1)
- `autorandr/home/` — external monitor on the left of laptop
- `autorandr/work/` — external monitor above laptop

## Desktop environment

Tokyo Night color scheme across all components:

| Component | Tool | Notes |
|-----------|------|-------|
| Window manager | i3wm | Gaps, vim-style navigation, container tree model |
| Status bar | Polybar | Layout indicator, keyboard, battery, wifi, CPU, memory, audio |
| Compositor | xcompmgr | Lightweight shadows (picom caused high CPU on Intel iGPU) |
| Launcher | Rofi | App launcher and window switcher |
| Notifications | Dunst | Styled notification popups |
| Terminal | WezTerm | GPU-accelerated, Tokyo Night theme |
| Wallpaper | feh | Wallpapers in `~/Pictures/Wallpapers/` |
| Monitors | autorandr | Auto-switches profiles on plug/unplug |
| Audio | PipeWire | Volume keys via `wpctl` |

### Dependencies

```bash
sudo apt install i3 polybar xcompmgr rofi dunst feh autorandr xdotool wireplumber
```

### Essential keybindings

| Key | Action |
|-----|--------|
| `$mod+Return` | Open terminal |
| `$mod+d` | App launcher (Rofi) |
| `$mod+h/j/k/l` | Focus left/down/up/right |
| `$mod+Shift+h/j/k/l` | Move window |
| `$mod+1-0` | Switch workspace |
| `$mod+w` | Tab siblings |
| `$mod+e` | Untab / toggle H/V |
| `$mod+v` / `$mod+b` | Next window opens below/right |

### Recovery keybindings

| Key | Action |
|-----|--------|
| `$mod+Shift+f` | Flatten workspace (fix nesting) |
| `$mod+Shift+p` | Relaunch polybar (fix missing bar) |
| `$mod+Ctrl+k` | Re-apply keyboard layout (fix Alt+Shift) |
| `$mod+o` | Move workspace to other monitor |
| `$mod+Shift+o` | Gather all workspaces to current monitor |

### Keyboard layouts

`br,us` with Alt+Shift toggle. System-level fix applied to `/etc/default/keyboard` so the setting persists across X11 events.

### Touchpad

Tap-to-click and natural scrolling enabled via `xinput` in the i3 config. Device name is hardcoded — adjust for different laptops.

### Audio (PipeWire)

Volume keys use `wpctl` (not `pactl`):
```
wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
```

### Monitor profiles

Autorandr manages three profiles — saved by monitor EDID (hardware fingerprint), auto-detected on plug/unplug:

- **mobile** — laptop only
- **home** — external monitor to the left
- **work** — external monitor above

Save a new profile after configuring with `xrandr`:
```bash
autorandr --save <profile-name> --force
```

All profiles share the same postswitch hook (`i3/postswitch.sh`) that restarts the compositor, relaunches polybar, restores the keyboard layout, fixes the cursor, and restores the wallpaper.

## Documentation

Interactive guides in `~/Documents/`:
- `i3.html` — unified entry point
- `i3-cheatsheet.html` — keybindings, containers, concepts, desktop
- `i3-concepts.html` — container tree model with SVG diagrams
- `i3-practice.html` — interactive lessons (learn by manipulating a simulated tree)

Terminal helpers:
- `i3tree` — prints the container tree with focus markers (installed in `~/bin/`)

## Install

```bash
chezmoi init git@github.com:erickZatlas/dotfiles.git
chezmoi diff    # review changes
chezmoi apply   # apply to home directory
```

## Update

```bash
chezmoi update
```

## Add new files

```bash
chezmoi add ~/.some-config
cd $(chezmoi source-path) && git add -A && git commit -m "feat: add some-config" && git push
```
