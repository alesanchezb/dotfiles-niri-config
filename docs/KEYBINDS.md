# Keybinds

Default keybinds, from `niri/.config/niri/keybinds.kdl`. `Mod` is the Super/Windows key.

## Windows & focus

| Key | Action |
|-----|--------|
| `Mod+Return` | Terminal (alacritty) |
| `Mod+Q` | Close window |
| `Mod+Backspace` | Quit Niri |
| `Mod+Left` / `Mod+Right` | Focus column left / right |
| `Mod+Up` / `Mod+Down` | Focus window up / down |
| `Mod+H` / `Mod+J` / `Mod+K` / `Mod+Semicolon` | Vim-ish focus movement |
| `Mod+F` | Maximize column |
| `Mod+W` | Toggle floating |
| `Alt+Return` | Fullscreen |

## Workspaces & overview

| Key | Action |
|-----|--------|
| `Mod+Tab` | Toggle overview (Win+Tab style) |
| `Mod+1..4` | Focus workspace |
| `Mod+Shift+1..4` | Move column to workspace |
| `Mod+Ctrl+Tab` / `Mod+Shift+Tab` | Cycle workspace down / up |

## Switcher (recent-windows)

| Key | Scope |
|-----|-------|
| `Alt+Tab` / `Alt+Shift+Tab` | All windows / current output |
| `Alt+grave` / `Alt+Shift+grave` | All windows, filtered by app |
| `Ctrl+Alt+Tab` / `Ctrl+Alt+Shift+Tab` | Current workspace |
| `Ctrl+Alt+grave` / `Ctrl+Alt+Shift+grave` | Current workspace, filtered by app |

## Launcher & tools

| Key | Action |
|-----|--------|
| `Mod+Space` | Launcher |
| `Mod+V` | Clipboard history |
| `Mod+C` | Calculator |
| `Mod+Ctrl+E` | Emoji picker |
| `Mod+,` | Settings |
| `Mod+Ctrl+K` | Hotkey overlay (cheatsheet) |
| `Mod+Ctrl+Q` | Session menu |
| `Mod+L` | Lock screen |
| `Mod+Ctrl+w` | Toggle wallpaper |

## Apps

| Key | Action |
|-----|--------|
| `Mod+B` | Zen browser |
| `Mod+P` | Nautilus |
| `Mod+M` | Spotify |
| `Mod+E` | Emacs (client) |
| `Mod+F1..F4` | Modes: dev / gaming / music / normal |

## Wallpaper

| Key | Action |
|-----|--------|
| `Mod+Shift+w` | Random wallpaper (from settings folder) |

## Screenshots

| Key | Action |
|-----|--------|
| `Print` | Full screenshot |
| `Ctrl+Print` | Current screen |
| `Alt+Print` | Focused window |

## Media, volume & brightness

| Key | Action |
|-----|--------|
| `XF86AudioPlay/Next/Prev` | playerctl media control |
| `XF86AudioRaise/Lower/Mute` | Volume OSD (noctalia IPC) |
| `F9` / `F10` / `F11` | Mute / volume down / volume up |
| `XF86MonBrightnessUp/Down` | Brightness OSD (noctalia IPC) |

## Misc

| Key | Action |
|-----|--------|
| `Mod+Shift+R` | Reload niri config |
| `XF86AudioMicMute` | Toggle mic mute (`wpctl`) |
