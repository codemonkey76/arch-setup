#!/usr/bin/env bash

set -euo pipefail

# Promp fr sudo once and keep it alive
init_sudo() {
    echo "🔐 Requesting sudo password..."
    sudo -v
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
        SUDO_LOOP_PID=$!
        trap 'kill $SUDO_LOOP_PID' EXIT
    }

setup_ssh() {
    echo "🔧 Setting up SSH key..."

    mkdir -p ~/.ssh
    chmod 700 ~/.ssh

    if [ ! -f ~/.ssh/id_ed25519 ]; then
        ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""
        echo "✅ SSH key generated at ~/.ssh/id_ed25519"
    else
        echo "ℹ️ SSH key already exists at ~/.ssh/id_ed25519 — skipping generation"
    fi

    echo "🔑 Public key:"
    cat ~/.ssh/id_ed25519.pub   
}

install_if_missing() {
    for pkg in "$@"; do
        if ! pacman -Q "$pkg" &>/dev/null; then
            echo "📦 Installing $pkg..."
            sudo pacman -S --noconfirm "$pkg"
        else
            echo "✅ $pkg is already installed"
        fi
    done
}

install_yay() {
    if ! command -v yay &>/dev/null; then
        echo "📦 Installing yay (AUR helper)..."
        echo "Installing yay..."
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        (cd /tmp/yay && makepkg -si --noconfirm)
        rm -rf /tmp/yay
    else
        echo "✅ yay is already installed"
    fi
}

aur_install_if_missing() {
    for pkg in "$@"; do
        if ! pacman -Q "$pkg" &>/dev/null; then
            echo "📦 Installing AUR package: $pkg..."
            yay -S --noconfirm "$pkg"
        else
            echo "✅ AUR package $pkg is already installed"
        fi
    done
}

main() {
    init_sudo

    echo "🚀 Starting system setup..."

    install_if_missing git base-devel openssh \
        xdg-desktop-portal-hyprland xdg-desktop-portal-gtk thunar

    echo "🧹 Removing unneeded packages..."
    sudo pacman -Rs dolpin kitty

    echo "🧹 Removing orphan packages..."
    orphans=$(pacman -Qdtq || true)
    if [ -n "$orphans" ]; then
        sudo pacman -Rns --noconfirm $orphans
    else
        echo "✅ No orphans to remove"
    fi

    install_yay
    aur_install_if_missing teamviewer rustdesk-bin wezterm-git

    setup_ssh
    sudo systemctl enable --now sshd

    sudo systemctl enable --now rustdesk
    sudo systemctl enable --now teamviewerd

    # Clone the DOTFILES repo
    # install pacman packages
    # setup AUR / yay
    # Install AUR packages
    # Setup rust toolchain
    # Install cargo packages.
    #
    echo "✅ Setup complete!"
}

main
