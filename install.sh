#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")" && pwd)/lib/setup-common.sh"

PULL=yes
AUR=yes
EMACS=ask
FULL=no
YES=no

usage() {
    cat <<EOF
Uso: $0 [opciones]

Instala los dotfiles: dependencias, enlazado con stow, noctalia y opcionalmente
el emacs-config.

Opciones:
  --no-pull   no hacer git pull del repo de dotfiles
  --no-aur    no instalar paquetes AUR (quickshell, matugen, fuentes...)
  --emacs     instalar emacs-config sin preguntar
  --no-emacs  no instalar emacs-config
  --full      incluir paquetes opcionales (cava, ytmdesktop)
  -y, --yes   asumir sí; no hace preguntas (emacs-config solo con --emacs)
  -h, --help  mostrar esta ayuda
EOF
    exit 0
}

while (($#)); do
    case "$1" in
        --no-pull)  PULL=no ;;
        --no-aur)   AUR=no ;;
        --emacs)    EMACS=yes ;;
        --no-emacs) EMACS=no ;;
        --full)     FULL=yes ;;
        -y|--yes)   YES=yes ;;
        -h|--help)  usage ;;
        *) die "opción desconocida: $1 (usa --help)" ;;
    esac
    shift
done

[ "$(id -u)" -eq 0 ] && die "ejecutar como usuario normal (el script usa sudo)"
have pacman || die "se requiere Arch Linux (pacman)"

info "Repo de dotfiles: $REPO_DIR"

if [ "$PULL" = yes ] && [ -d "$REPO_DIR/.git" ]; then
    info "Actualizando dotfiles (git pull)..."
    (cd "$REPO_DIR" && git pull --ff-only) || warn "no se pudo hacer pull (¿cambios locales?)"
fi

[ "$AUR" = yes ] && install_yay

install_base

if [ "$AUR" = yes ]; then
    install_aur "${AUR_PKGS[@]}"
fi

if [ "$FULL" = yes ] || { [ "$YES" = no ] && ask_yes "¿Instalar extras opcionales (cava, ytmdesktop)?"; }; then
    install_aur "${OPTIONAL_PKGS[@]}"
fi

have stow || die "stow no está instalado"
prep_stow
stow_pkgs
ok "dotfiles enlazados vía stow: ${STOW_PKGS[*]}"

seed_noctalia

if [ ! -d "$WALLPAPER_DIR" ]; then
    mkdir -p "$WALLPAPER_DIR"
    info "creada carpeta de wallpapers: $WALLPAPER_DIR"
fi

# --- emacs-config (opcional) ---
install_emacs() {
    local yn
    case "$EMACS" in
        yes) yn=y ;;
        no)  yn=n ;;
        *)
            if [ "$YES" = yes ]; then
                yn=n
            elif ask_yes "¿Instalar emacs-config desde https://github.com/alesanchezb/emacs-config?"; then
                yn=y
            else
                yn=n
            fi
            ;;
    esac
    [ "$yn" = y ] || { info "emacs-config omitido"; return; }

    mkdir -p "$HOME/.repos"
    if [ -d "$HOME/.repos/emacs-config/.git" ]; then
        info "emacs-config ya clonado en ~/.repos/emacs-config"
        [ "$PULL" = yes ] && (cd "$HOME/.repos/emacs-config" && git pull --ff-only) || warn "emacs-config: no se pudo hacer pull"
    else
        git clone https://github.com/alesanchezb/emacs-config "$HOME/.repos/emacs-config"
    fi

    info "Ejecutando el instalador de emacs-config (compila Emacs desde fuente)..."
    bash "$HOME/.repos/emacs-config/scripts/install.sh"
}

install_emacs

cat <<EOF

${C_BOLD}Setup completado.${C_RESET}
- Enlazado vía stow: niri, quickshell, rofi, scripts
- Recarga niri con: niri msg action load-config-file
- Backup de configs previas (si hubo): $BACKUP_DIR
- Ajustes de noctalia: Mod+, (settings) · Mod+Ctrl+K (overlay de hotkeys)
EOF
