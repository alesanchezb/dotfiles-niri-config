# Packages

Everything the installer (`install.sh`) uses, by category. Lists mirror `lib/setup-common.sh`.

## Base (official repos, via `pacman`)

| Package | Purpose |
|---------|---------|
| `niri` | The compositor |
| `rofi` | Launcher menus (wallpaper, powermenu, clipboard…) |
| `alacritty` | Terminal (`Mod+Return`) |
| `nautilus` | File manager (`Mod+P`) |
| `emacs` | Emacs client (`Mod+E`) |
| `playerctl` | Media keys |
| `brightnessctl` | Backlight control |
| `grim` / `slurp` | Screenshots / region selection |
| `wl-clipboard` | Wayland clipboard (`wl-paste --watch cliphist store`) |
| `cliphist` | Clipboard history backend |
| `libnotify` | `notify-send` |
| `stow` | Symlink management |
| `git`, `curl`, `wget`, `unzip`, `jq` | Tooling |
| `xdg-utils`, `xdg-user-dirs` | XDG plumbing |
| `power-profiles-daemon` | Power profiles (noctalia widget) |
| `networkmanager` | Network (noctalia WiFi widget) |
| `bluez`, `bluez-utils` | Bluetooth (noctalia widget) |
| `pipewire`, `pipewire-pulse`, `wireplumber` | Audio stack (`wpctl`) |
| `pavucontrol` | Volume fallback mixer |
| `noto-fonts`, `noto-fonts-emoji` | Glyphs and emoji in the bar |

## AUR (via `yay`)

| Package | Purpose |
|---------|---------|
| `quickshell-git` | Shell framework that runs noctalia-shell |
| `matugen-bin` | Wallpaper-based color theming |
| `ttf-jetbrains-mono-nerd` | Terminal/UI font used by rofi & noctalia |
| `ttf-iosevka-nerd` | Alternate UI font |
| `zen-browser` | Browser (`Mod+B`) |
| `spotify-launcher` | Spotify client (`Mod+M`) |

## Optional (asked by the installer, or `--full`)

| Package | Purpose |
|---------|---------|
| `cava` | Audio visualizer in the bar |
| `ytmdesktop` | YouTube Music client (`mode-music.sh`) |
