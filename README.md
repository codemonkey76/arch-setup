# 🏗️ Arch Linux Post-Install Setup

This script automates the essential setup steps for a fresh Arch Linux installation, including:

- Installing required packages via `pacman` and `yay`
- Removing unneeded packages
- Enabling SSH and remote support
- Setting up your SSH key
- Installing AUR helpers and tools

---

## 🚀 Quick Start

After you've booted into your new Arch install and created your regular user account:

### 1. Ensure you're logged in as a **non-root user**

```bash
whoami
```
Make sure it is **not** `root`.

---

### 2. Download and run the setup script

Using `curl`:
```bash
bash <(curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/setup.sh)

```

Or using `wget`:
```bash
bash <(wget -qO- https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/setup.sh)
```

> 🛑 Do NOT run this script as root. It will use sudo only where necessary.

## 🧩 What it installs

- 📦 Base packages: `git`, `base-devel`, `openssh`, `thunar`, and xdg portal tools
- 🔁 Removes: `dolphin`, `kitty` (if present)
- 🔧 AUR tools: `yay`, `teamviewer`, `rustdesk-bin`, `wezterm-git`
- 🔑 Generates an SSH key (if missing)
- 🧹 Cleans up orphaned packages
- ⚙️ Enables and starts: sshd, rustdesk, teamviewerd

- Base packages: `git`, `base-devel`, `openssh`, `thunar`, and xdg portal tools  
- Removes: `dolphin`, `kitty` (if present)  
- AUR tools: `yay`, `teamviewer`, `rustdesk-bin`, `wezterm-git`  
- Generates an SSH key (if missing)  
- Cleans up orphaned packages  
- Enables and starts: `sshd`, `rustdesk`, `teamviewerd`  

---

## 📝 Optional Next Steps

After running this script, you might want to:

- Clone your dotfiles repo and symlink config files  
- Set up your shell (e.g. `zsh`, `oh-my-zsh`, `starship`)  
- Install a terminal multiplexer like `tmux`  
- Configure Neovim or another editor  

---

## 🛠️ Requirements

- A freshly installed Arch Linux system  
- A regular (non-root) user account with `sudo` privileges  
- Internet access  

---

## ⚠️ Safety Notes

- This script uses `set -euo pipefail` to fail fast on errors  
- It will prompt once for your sudo password and keep it cached  
- All user-specific configuration is done under your home directory (`~`)  

---

## 📁 Repository Layout

- `setup.sh` – Main setup script  
- `README.md` – This file  

---

## 📬 Feedback

Feel free to fork and customize, or open issues to improve this script for your workflow.
