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
- `i3/config` - i3wm configuration (keybindings, workspaces, appearance)
- `i3/kb-layout.sh` - Keyboard layout wrapper script (unused, replaced by polybar module)
- `i3status/config` - i3status configuration (kept as fallback for polybar)

### Polybar
- `polybar/config.ini` - Status bar with Tokyo Night theme
- `polybar/launch.sh` - Multi-monitor launch script

### Compositor
- `picom/picom.conf` - Picom configuration (kept as reference, currently using xcompmgr)

### Application Launcher
- `rofi/config.rasi` - Rofi launcher with Tokyo Night theme

### Notifications
- `dunst/dunstrc` - Dunst notification daemon with Tokyo Night theme

### Monitor Management
- `autorandr/mobile/postswitch` - Restarts compositor when external monitor is unplugged
- `autorandr/docked/postswitch` - Restarts compositor when external monitor is plugged in

## Desktop environment

The i3 setup uses the **Tokyo Night** color scheme across all components:

| Component | Tool | Notes |
|-----------|------|-------|
| Window manager | i3wm | Gaps, vim-style navigation |
| Status bar | Polybar | Keyboard layout, battery, network, audio, etc. |
| Compositor | xcompmgr | Lightweight shadows (picom caused high CPU on Intel Raptor Lake) |
| Launcher | Rofi | App launcher and window switcher |
| Notifications | Dunst | Styled notification popups |
| Terminal | WezTerm | GPU-accelerated terminal |
| Wallpaper | feh | Tokyo Night wallpapers in `~/Pictures/Wallpapers/` |
| Monitors | autorandr | Auto-switches profiles on plug/unplug |

### Dependencies

```bash
sudo apt install i3 polybar xcompmgr rofi dunst feh autorandr
```

### Keyboard

- **Alt+Shift** toggles between `br` (Brazilian Portuguese) and `us` (English) layouts
- Layout indicator is shown in polybar's `xkeyboard` module

### Touchpad

Tap-to-click and natural scrolling are enabled via `xinput` in the i3 config. The device name is hardcoded — adjust if using a different laptop.

### Monitor profiles

Autorandr manages two profiles:

- **mobile** - Laptop screen only (eDP-1)
- **docked** - External monitor on the left (HDMI-1) + laptop

Save new profiles with:
```bash
autorandr --save <profile-name>
```

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
