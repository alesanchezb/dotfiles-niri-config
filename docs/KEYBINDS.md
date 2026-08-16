# Keybinds

Keybinds de niri (de `niri/.config/niri/keybinds.kdl`) y de los paneles de
noctalia (de `noctalia/.config/noctalia/config.toml`, sección `[keybinds]`).
`Mod` es la tecla Super/Windows.

## Windows & focus

| Key | Action |
|-----|--------|
| `Mod+Return` | Terminal (alacritty) |
| `Mod+Q` | Close window |
| `Mod+Backspace` | Session menu (logout / power) |
| `Mod+Left` / `Mod+Right` | Focus column or monitor left / right |
| `Mod+Up` / `Mod+Down` | Focus workspace up / down |
| `Mod+H` / `Mod+K` | Focus column or monitor left / right |
| `Mod+J` / `Mod+U` | Focus down / up (column → workspace → monitor) |
| `Mod+Ctrl+Left` / `Mod+Ctrl+Right` | Focus monitor left / right |
| `Mod+Ctrl+Up` / `Mod+Ctrl+Down` | Focus workspace up / down |
| `Mod+Ctrl+H` / `Mod+Ctrl+K` | Focus monitor left / right |
| `Mod+Ctrl+U` / `Mod+Ctrl+J` | Focus workspace up / down |
| `Mod+Semicolon` | Focus column right |
| `Mod+F` | Maximize column |
| `Mod+W` | Toggle floating |
| `Alt+Return` | Fullscreen |

## Workspaces & overview

| Key | Action |
|-----|--------|
| `Mod+Tab` | Toggle overview (Win+Tab style) |
| `Mod+Ctrl+Tab` / `Mod+Shift+Tab` | Cycle workspace down / up |
| `Mod+1..4` | Focus workspace |
| `Mod+Shift+1..4` | Move column to workspace |

## Switcher (recent-windows)

| Key | Scope |
|-----|-------|
| `Alt+Tab` | Next window (all) |
| `Alt+Shift+Tab` | Next window (workspace) |
| `Alt+Ctrl+Tab` | Previous window (output) |
| `Alt+grave` / `Alt+Shift+grave` | Next / previous (all, filtered by app) |
| `Ctrl+Alt+Shift+Tab` | Previous window (workspace) |
| `Ctrl+Alt+grave` / `Ctrl+Alt+Shift+grave` | Next / previous (workspace, filtered by app) |

## Launcher & tools

| Key | Action |
|-----|--------|
| `Mod+Space` | Launcher |
| `Mod+V` | Clipboard history |
| `Mod+C` | Calculator |
| `Mod+Ctrl+E` | Emoji picker |
| `Mod+,` | Settings |
| `Mod+S` | Control center |
| `Mod+Ctrl+O` | Hotkey overlay (cheatsheet) |
| `Mod+Ctrl+Q` | Session menu |
| `Mod+L` | Lock screen |
| `Mod+Shift+w` | Random wallpaper |
| `Mod+Ctrl+t` | Wallhaven browser (wallpaper picker) |

## Apps

| Key | Action |
|-----|--------|
| `Mod+B` | Zen browser |
| `Mod+P` | Nautilus |
| `Mod+M` | Spotify |
| `Mod+E` | Emacs (client) |
| `Mod+F1..F4` | Modes: dev / gaming / music / normal |

## Launcher & paneles (noctalia)

Vigentes mientras un panel de noctalia tiene el foco (launcher, control center,
clipboard, etc.). Navegación con estilo emacs: `Ctrl+n` / `Ctrl+p` se suman a
las flechas para mover la selección.

| Key | Acción |
|-----|--------|
| `Up` / `Ctrl+p` | Selección anterior |
| `Down` / `Ctrl+n` | Selección siguiente |
| `Left` / `Right` | Navegación horizontal |
| `Return` / `Space` | Activar selección (launcher) |
| `Tab` / `Shift+Tab` | Siguiente / anterior pestaña o campo |
| `Escape` | Cerrar panel / cancelar |
| `Ctrl+c` / `Ctrl+s` | Copiar / guardar |
| `Delete` | Eliminar |

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