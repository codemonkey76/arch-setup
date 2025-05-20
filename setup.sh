#!/usr/bin/env bash
# Install base pacman packages
setup_ssh() {
	echo "🔧 Setting up SSH key..."

    # Ensure ~/.ssh exists with proper permissions
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh

    # Only generate key if it doesn't exist
    if [ ! -f ~/.ssh/id_ed25519 ]; then
        ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""
        echo "✅ SSH key generated at ~/.ssh/id_ed25519"
    else
        echo "ℹ️ SSH key already exists at ~/.ssh/id_ed25519 — skipping generation"
    fi

    # Show the public key
    echo "🔑 Public key:"
    cat ~/.ssh/id_ed25519.pub	
}

install_if_missing() {
	for pkg in "$@"; do
		if ! pacman -Q "$pkg" &>/dev/null; then
			echo "Installing $pkg..."
			sudo pacman -S --noconfirm "$pkg"
		else
			echo "$pkg is already installed"
		fi
	done
}

install_yay() {
	if ! command -v yay &>/dev/null; then
		echo "Installing yay..."
		git clone https://aur.archlinux.org/yay.git /tmp/yay
		(cd /tmp/yay && makepkg -si --noconfirm)
		rm -rf /tmp/yay
	else
		echo "yay is already installed"
	fi
}

aur_install_if_missing() {
	for pkg in "$@"; do
		if ! pacman -Q "$pkg" &>/dev/null; then
			echo "Installing AUR packages $pkg..."
			yay -S --noconfirm "$pkg"
		else
			echo "AUR package $pkg is already installed"
		fi
	done
}

main() {
	install_if_missing git base-devel openssh xdg-desktop-portal-hyprland xdg-desktop-portal-gtk thunar
	sudo pacman -Rs dolpin kitty
	echo "Remove orphan packages"
	sudo pacman -Rns $(pacman -Qdtq)
	install_yay
	aur_install_if_missing teamviewer rustdesk-bin wezterm-git

	# Setup SSH
	setup_ssh
	sudo systemctl enable --now sshd

	# Setup Teamviewer and RustDesk
	sudo systemctl enable --now rustdesk
	sudo systemctl enable --now teamviewerd

	# Clone the DOTFILES repo
	# install pacman packages
	# setup AUR / yay
	# Install AUR packages
	# Setup rust toolchain
	# Install cargo packages.
	#
}

main




