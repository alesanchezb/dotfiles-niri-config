# Installation

Arch-based distributions only (the installer uses `pacman` and `yay`).

## Quick install

```bash
git clone https://github.com/alesanchezb/dotfiles-niri-config.git
cd dotfiles
./install.sh
```

The installer:

1. Installs `yay` (AUR helper) if missing.
2. Installs the base packages (see [PACKAGES.md](PACKAGES.md)).
3. Installs the AUR packages (noctalia, matugen, fonts, zen-browser…).
4. Asks for optional extras: `cava`, `ytmdesktop`.
5. Backs up any conflicting configs to `~/.dotfiles-backup/` and links everything with `stow`.
6. Creates the wallpaper folder (`~/Pictures/wallpapers`).
7. Asks if you want to install the [emacs-config](https://github.com/alesanchezb/emacs-config) (compiles Emacs from source).

## Options

| Flag | What it does |
|------|--------------|
| `--no-pull` | Skip the `git pull` before installing |
| `--no-aur` | Skip AUR packages (noctalia, matugen…) |
| `--emacs` | Install emacs-config without asking |
| `--no-emacs` | Skip the emacs-config prompt |
| `--full` | Include optional packages without asking |
| `-y, --yes` | Assume yes, no prompts |

## Manual install (no script)

```bash
# Dependencies
sudo pacman -S --needed niri rofi alacritty nautilus emacs playerctl brightnessctl \
    grim slurp wl-clipboard cliphist libnotify stow git curl wget unzip jq xdg-utils \
    xdg-user-dirs power-profiles-daemon networkmanager bluez bluez-utils \
    pipewire pipewire-pulse wireplumber pavucontrol noto-fonts noto-fonts-emoji

# AUR
yay -S --needed noctalia-git quickshell-git matugen-bin ttf-jetbrains-mono-nerd \
    ttf-iosevka-nerd zen-browser spotify-launcher

# Link configs
cd dotfiles
stow -t "$HOME" niri rofi scripts applications environment noctalia
```

## After installing

- Log in to Niri (it spawns `noctalia` at startup automatically).
- The shell config lives in `~/.config/noctalia/config.toml` (stow-linked). Theme source, wallpaper folder and plugins are declared there.
- Add wallpapers to `~/Pictures/wallpapers` (the default) and pick one from the control center or the Wallhaven browser (`Mod+Ctrl+t`).
- Change the color scheme from the Settings GUI (`Mod+,`).

## Troubleshooting the install

```bash
niri validate           # checks the compositor config
noctalia config validate  # checks the shell config
noctalia msg --help     # IPC reference (listens for shell events)
```