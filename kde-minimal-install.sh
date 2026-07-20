#!/usr/bin/env bash

# Exit immediately on errors or unset variables
set -euo pipefail

# Ensure the script is run with root/sudo privileges
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script with sudo or as root."
  exit 1
fi

echo "=========================================="
echo "  Installing Fedora KDE Minimal Desktop   "
echo "=========================================="

echo " Refreshing DNF package metadata "
dnf check-update || true

echo " Installing core KDE applications "
dnf install -y \
  konsole \
  dolphin \
  dolphin-plugins \
  plasma-desktop

echo "=========================================="
echo "   KDE Minimal Installed Successfully!    "
echo "=========================================="
