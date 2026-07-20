#!/usr/bin/env bash

# Exit immediately on errors or unset variables
set -euo pipefail

# Ensure the script is run with root/sudo privileges
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script with sudo or as root."
  exit 1
fi

echo "=========================================="
echo "        Multimedia Codecs Setup           "
echo "=========================================="

# Ensure RPM Fusion Free is enabled
if ! dnf repolist | grep -q "rpmfusion-free"; then
  echo " Enabling RPM Fusion repositories "
  dnf install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm
fi

echo -n "Swap ffmpeg-free with full ffmpeg (system-wide codec support)? [y/N]: "
read -r resp_ffmpeg

if [[ "$resp_ffmpeg" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  echo " Refreshing DNF package metadata "
  dnf check-update || true

  echo " Swapping to full ffmpeg "
  dnf swap -y ffmpeg-free ffmpeg --allowerasing

  echo "=========================================="
  echo "       Multimedia Setup Completed!        "
  echo "=========================================="
else
  echo " Skipping multimedia setup "
fi
