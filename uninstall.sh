#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")" && pwd)/lib/setup-common.sh"

info "Desenlazando configs (stow -D)..."
unstow_pkgs
ok "symlinks removidos: ${STOW_PKGS[*]}"

if ask_yes "¿Desinstalar también los paquetes instalados por el setup? ¡CUIDADO: incluye niri, noctalia y rofi!"; then
    info "Desinstalando paquetes del sistema: ${BASE_PKGS[*]}"
    sudo pacman -Rns --noconfirm "${BASE_PKGS[@]}" || warn "algunos paquetes no se pudieron remover (¿están en uso?)"
    if have yay; then
        info "Desinstalando paquetes AUR: ${AUR_PKGS[*]}"
        yay -Rns --noconfirm "${AUR_PKGS[@]}" || warn "algunos paquetes AUR no se pudieron remover"
    fi
else
    info "Paquetes conservados"
fi

if [ -d "$HOME/.repos/emacs-config" ] && ask_yes "¿Eliminar ~/.repos/emacs-config?"; then
    rm -rf "$HOME/.repos/emacs-config"
    ok "eliminado ~/.repos/emacs-config"
fi

info "Listo. Si el setup respaldó configs previas, están en: ~/.dotfiles-backup/"
