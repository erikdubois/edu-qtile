#!/bin/bash
set -euo pipefail
############################################################
# Author    : Erik Dubois
# Website   : https://kiroproject.be
############################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
#   Purpose:
#   - Install or remove the Wayland-only runtime packages that the
#     kiro-qtile-wayland config calls but that are NOT part of a stock
#     X11 install: grim + slurp (screenshots), swaybg (wallpaper),
#     brightnessctl (brightness keys) and python-dbus-fast (the
#     StatusNotifier system tray). qtile itself already pulls the
#     wlroots backend, so it is not listed here.
#
#   Usage:
#     ./wayland-deps.sh install   # add the packages
#     ./wayland-deps.sh remove    # take them back out (-Rns)
#
#   Why: a quick test toggle so a Wayland session can be tried on a
#   box, then returned to its previous state without hunting down
#   each package by hand.
#
############################################################

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

PACKAGES=(grim slurp swaybg brightnessctl python-dbus-fast)

############################################################
# Colors
############################################################
if command -v tput >/dev/null 2>&1 && [[ -t 1 ]]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    CYAN="$(tput setaf 6)"
    RESET="$(tput sgr0)"
else
    RED="" GREEN="" YELLOW="" BLUE="" CYAN="" RESET=""
fi

############################################################
# Logging
############################################################
log_section() {
    echo
    echo "${GREEN}############################################################${RESET}"
    echo "$1"
    echo "${GREEN}############################################################${RESET}"
    echo
}

log_info() {
    echo
    echo "${BLUE}############################################################${RESET}"
    echo "$1"
    echo "${BLUE}############################################################${RESET}"
    echo
}

log_warn() {
    echo
    echo "${YELLOW}############################################################${RESET}"
    echo "$1"
    echo "${YELLOW}############################################################${RESET}"
    echo
}

log_error() {
    echo
    echo "${RED}############################################################${RESET}"
    echo "$1"
    echo "${RED}############################################################${RESET}"
    echo
}

log_success() {
    echo
    echo "${GREEN}############################################################${RESET}"
    echo "$1"
    echo "${GREEN}############################################################${RESET}"
    echo
}

############################################################
# Error handling
############################################################
on_error() {
    local lineno="$1"
    local cmd="$2"
    echo
    echo "${RED}ERROR on line ${lineno}: ${cmd}${RESET}"
    echo
    sleep 10
}

trap 'on_error "$LINENO" "$BASH_COMMAND"' ERR

############################################################
# Functions
############################################################
usage() {
    echo "Usage: $(basename "$0") {install|remove}"
    echo "  install   add: ${PACKAGES[*]}"
    echo "  remove    remove the same packages (pacman -Rns)"
}

install_packages() {
    log_section "Installing Wayland packages: ${PACKAGES[*]}"
    sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"
    log_success "Wayland packages installed"
}

remove_packages() {
    log_section "Removing Wayland packages: ${PACKAGES[*]}"
    # Only act on packages that are actually installed; -Rns also drops
    # now-orphaned dependencies. pacman refuses if something still needs one.
    local present=()
    local pkg
    for pkg in "${PACKAGES[@]}"; do
        if pacman -Q "${pkg}" >/dev/null 2>&1; then
            present+=("${pkg}")
        else
            log_warn "${pkg} is not installed — skipping"
        fi
    done

    if [[ ${#present[@]} -eq 0 ]]; then
        log_info "Nothing to remove"
        return
    fi

    sudo pacman -Rns --noconfirm "${present[@]}"
    log_success "Wayland packages removed"
}

############################################################
# Main
############################################################
main() {
    if [[ $# -ne 1 ]]; then
        usage
        exit 1
    fi

    case "$1" in
        install) install_packages ;;
        remove)  remove_packages ;;
        *)
            log_error "Unknown action: $1"
            usage
            exit 1
            ;;
    esac

    log_success "$(basename "$0") done"
}

main "$@"
