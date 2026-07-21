#!/usr/bin/env bash

# Exit immediately on errors or unset variables
set -euo pipefail

# Ensure the script is run with root/sudo privileges
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script with sudo or as root."
  exit 1
fi

echo "=========================================="
echo "   Installing Fedora KDE Minimal Desktop   "
echo "=========================================="

echo " Refreshing DNF package metadata "
dnf check-update || true

echo " Installing core KDE applications "
dnf install -y \
  dolphin \
  dolphin-plugins \
  konsole \
  kwalletmanager \
  ksshaskpass \
  kinfocenter \
  kde-gtk-config \
  kscreen \
  plasma-desktop \
  plasma-login-manager \
  plasma-nm \
  plasma-firewall

echo " Enabling display manager service "
systemctl enable --force plasmalogin.service
systemctl set-default graphical.target

echo "=========================================="
echo "    KDE Minimal Installed Successfully!    "
echo "=========================================="
