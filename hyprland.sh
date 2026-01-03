#!/bin/bash

set -e

PACKAGES=(
  wlogout
)

echo "🔄Updating system and installing packages..."
sudo pacman -Syu --needed "${PACKAGES[@]}"

echo "✨Installation Successful!! ✅"
