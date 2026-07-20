#!/usr/bin/env bash

# Exit immediately on errors or unset variables
set -euo pipefail

# Ensure the script is run with root/sudo privileges
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script with sudo or as root."
  exit 1
fi

echo "=========================================="
echo "    Installing Apps & CLI Utilities       "
echo "=========================================="

# Array to hold packages selected for installation
CHOSEN_PACKAGES=()
NEED_BRAVE_REPO=false
NEED_RPM_FUSION=false

echo " Please select which applications you want to install:"

# 1. Brave Origin Browser
echo -n "Install 'brave-origin' (Stripped-down, bloat-free Brave browser)? [y/N]: "
read -r resp_brave
if [[ "$resp_brave" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CHOSEN_PACKAGES+=(brave-origin)
  NEED_BRAVE_REPO=true
fi

# 2. bat
echo -n "Install 'bat' (Cat alternative with syntax highlighting)? [y/N]: "
read -r resp_bat
if [[ "$resp_bat" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CHOSEN_PACKAGES+=(bat)
fi

# 3. eza
echo -n "Install 'eza' (Modern, feature-rich replacement for ls)? [y/N]: "
read -r resp_eza
if [[ "$resp_eza" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CHOSEN_PACKAGES+=(eza)
fi

# 4. fastfetch
echo -n "Install 'fastfetch' (Fast system information display tool)? [y/N]: "
read -r resp_fastfetch
if [[ "$resp_fastfetch" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CHOSEN_PACKAGES+=(fastfetch)
fi

# 5. Steam
echo -n "Install 'steam' (Digital gaming platform)? [y/N]: "
read -r resp_steam
if [[ "$resp_steam" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CHOSEN_PACKAGES+=(steam)
  NEED_RPM_FUSION=true
fi

echo "---------------------------------------------------------"

# Execute installation if any packages were chosen
if [ ${#CHOSEN_PACKAGES[@]} -gt 0 ]; then

  # Add the Brave repository if Brave Origin was selected
  if [ "$NEED_BRAVE_REPO" = true ]; then
    echo " Adding Brave RPM repository "
    dnf install -y dnf-plugins-core
    dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
  fi

  # Enable RPM Fusion if Steam was selected
  if [ "$NEED_RPM_FUSION" = true ]; then
    echo " Enabling RPM Fusion repositories "
    dnf install -y \
      https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm \
      https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm
    dnf config-manager setopt fedora-cisco-openh264.enabled=1 || true
  fi

  echo " Refreshing DNF package metadata "
  dnf check-update || true

  echo " Installing selected applications "
  dnf install -y "${CHOSEN_PACKAGES[@]}"

  echo "=========================================="
  echo "   Applications Installed Successfully!   "
  echo "=========================================="
else
  echo " No applications selected. Skipping installation "
fi
