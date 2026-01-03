#!/bin/bash

set -e

PACKAGES=(
  ttf-font-awesome 
  ttf-jetbrains-mono-nerd
  git
  zip
  unzip
  ripgrep
  nvm
  tmux
  base-devel
  neovim-git
)

echo "🔄Updating system and installing packages..."
sudo pacman -Syu --needed "${PACKAGES[@]}"

echo "🔡 Updating font cache..."
fc-cache -fv

echo "📦Setting up NVM..."

if ! grep -q "source /usr/share/nvm/init-nvm.sh" ~/.bashrc; then
  echo "Adding nvm init.sh to .bashrc..."
  echo "source /usr/share/nvm/init-nvm.sh" >> ~/.bashrc
else 
  echo "nvm already present in .bashrc..."
fi

source /usr/share/nvm/init-nvm.sh
nvm install 22
nvm use 22

echo "📟Setting up TMUX..."
if ! grep -q "alias tmux=" ~/.bashrc; then
    echo "Adding tmux alias to .bashrc..."
    echo "alias tmux='tmux -u'" >> ~/.bashrc
else
    echo "Tmux alias already exists in .bashrc, skipping..."
fi

echo "✨Installation Successful!! ✅"
