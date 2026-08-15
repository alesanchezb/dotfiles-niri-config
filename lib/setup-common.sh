#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

STOW_PKGS=(niri quickshell rofi scripts applications environment noctalia)

BASE_PKGS=(
    niri
    rofi
    alacritty
    nautilus
    emacs
    playerctl
    brightnessctl
    grim
    slurp
    wl-clipboard
    cliphist
    libnotify
    stow
    git
    curl
    wget
    unzip
    jq
    xdg-utils
    xdg-user-dirs
    power-profiles-daemon
    networkmanager
    bluez
    bluez-utils
    pipewire
    pipewire-pulse
    wireplumber
    pavucontrol
    noto-fonts
    noto-fonts-emoji
)

AUR_PKGS=(
    noctalia-git
    quickshell-git
    matugen-bin
    ttf-jetbrains-mono-nerd
    ttf-iosevka-nerd
    zen-browser
    spotify-launcher
)

OPTIONAL_PKGS=(cava ytmdesktop)

NOCTALIA_SCHEME="${NOCTALIA_SCHEME:-Nord}"
WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures/wallpapers}"

# --- colors ---
C_RESET='\033[0m'
C_BOLD='\033[1m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[0;33m'
C_RED='\033[0;31m'
C_CYAN='\033[0;36m'

info() { printf "${C_CYAN}::${C_RESET} %s\n" "$*"; }
ok()   { printf "${C_GREEN}✔${C_RESET} %s\n" "$*"; }
warn() { printf "${C_YELLOW}⚠${C_RESET} %s\n" "$*" >&2; }
die()  { printf "${C_RED}✘${C_RESET} %s\n" "$*" >&2; exit 1; }

have() { command -v "$1" >/dev/null 2>&1; }

ask_yes() {
    local prompt="$1" yn
    read -rp "${prompt} [y/N] " yn
    [[ "$yn" =~ ^[Yy]$ ]]
}

pkg_installed() { pacman -Q "$1" >/dev/null 2>&1; }

install_base() {
    local p missing=()
    for p in "${BASE_PKGS[@]}"; do pkg_installed "$p" || missing+=("$p"); done
    if ((${#missing[@]})); then
        info "Instalando paquetes del sistema: ${missing[*]}"
        sudo pacman -S --needed --noconfirm "${missing[@]}"
    else
        ok "paquetes del sistema ya instalados"
    fi
}

install_aur() {
    local helper p missing=()
    if have paru; then helper=paru; elif have yay; then helper=yay; else die "no hay yay/paru (helper AUR)"; fi
    for p in "$@"; do pkg_installed "$p" || missing+=("$p"); done
    if ((${#missing[@]})); then
        info "Instalando paquetes AUR: ${missing[*]}"
        "$helper" -S --needed --noconfirm "${missing[@]}"
    else
        ok "paquetes AUR ya instalados: $*"
    fi
}

install_yay() {
    have yay && return 0
    info "Instalando yay (helper AUR)..."
    sudo pacman -S --needed --noconfirm base-devel git
    local tmp
    tmp="$(mktemp -d)"
    git clone https://aur.archlinux.org/yay.git "$tmp/yay"
    (cd "$tmp/yay" && makepkg -si --noconfirm)
    rm -rf "$tmp"
    ok "yay instalado"
}

# --- stow ---
stow_pkgs()   { (cd "$REPO_DIR" && stow -t "$HOME" "${STOW_PKGS[@]}"); }
unstow_pkgs() { (cd "$REPO_DIR" && stow -D -t "$HOME" "${STOW_PKGS[@]}"); }

BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

backup_target() {
    local tgt="$1" target="$HOME/$1"
    mkdir -p "$BACKUP_DIR/$(dirname "$tgt")"
    warn "respaldo: $tgt → $BACKUP_DIR/$tgt"
    mv "$target" "$BACKUP_DIR/$tgt"
}

# Mueve/aside lo que colisione con stow para que stow quede dueño del árbol.
prep_stow() {
    local pkg tgt target
    for pkg in "${STOW_PKGS[@]}"; do
        while IFS= read -r tgt; do
            [ -n "$tgt" ] || continue
            target="$HOME/$tgt"
            if [ -L "$target" ]; then
                if [[ "$(readlink -f "$target")" == "$REPO_DIR"* ]]; then
                    rm -f "$target"
                    ok "reemplazado symlink previo: $tgt"
                else
                    backup_target "$tgt"
                fi
            else
                backup_target "$tgt"
            fi
        done < <( (cd "$REPO_DIR" && stow -n -t "$HOME" -v "$pkg") 2>&1 |
                  sed -n 's/.*is not owned by stow: \([^ ]*\).*/\1/p;
                          s/.*is neither a regular file nor a symlink: \([^ ]*\).*/\1/p;
                          s/.*over existing target \([^ ]*\).*/\1/p' )
    done
}

# --- noctalia settings ---
seed_noctalia() {
    local settings="$HOME/.config/noctalia/settings.json"
    local default="$REPO_DIR/quickshell/.config/quickshell/noctalia-shell/Assets/settings-default.json"
    if [ ! -f "$settings" ] && [ -f "$default" ]; then
        mkdir -p "$HOME/.config/noctalia"
        cp "$default" "$settings"
        info "creado settings.json de noctalia desde el default"
    fi
    if [ ! -f "$settings" ]; then
        warn "no se pudo sembrar noctalia (falta settings.json)"
        return
    fi
    local tmp
    tmp="$(mktemp)"
    if jq --arg scheme "$NOCTALIA_SCHEME" --arg wp "$WALLPAPER_DIR" \
          '.colorSchemes.predefinedScheme=$scheme | .wallpaper.directory=$wp | .wallpaper.overviewEnabled=true | .appLauncher.enableClipboardHistory=true' \
          "$settings" > "$tmp"; then
        mv "$tmp" "$settings"
        ok "noctalia: preset '$NOCTALIA_SCHEME', wallpapers en $WALLPAPER_DIR"
    else
        rm -f "$tmp"
        warn "no se pudo actualizar noctalia settings"
    fi
}
