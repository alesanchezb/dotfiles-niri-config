#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")" && pwd)/lib/setup-common.sh"

UPGRADE_AUR=no
for arg in "$@"; do
    case "$arg" in
        --packages) UPGRADE_AUR=yes ;;
        -h|--help)
            echo "Uso: $0 [--packages]"
            echo "  --packages  además actualiza paquetes AUR (yay -Sua)"
            exit 0
            ;;
        *) die "opción desconocida: $arg" ;;
    esac
done

info "Actualizando dotfiles (git pull)..."
(cd "$REPO_DIR" && git pull --ff-only) || warn "no se pudo hacer pull (¿cambios locales?)"

have stow || die "stow no está instalado"
prep_stow
stow_pkgs
ok "dotfiles re-enlazados vía stow"

if have niri && pgrep -x niri >/dev/null 2>&1; then
    niri msg action load-config-file
    ok "config de niri recargada"
fi

if [ "$UPGRADE_AUR" = yes ]; then
    install_yay
    if have paru; then
        paru -Sua --noconfirm
    elif have yay; then
        yay -Sua --noconfirm
    fi
    ok "paquetes AUR actualizados"
fi

info "update listo"
