#!/usr/bin/env bash

# Exit immediately on errors or unset variables
set -euo pipefail

# Ensure the script is run with root/sudo privileges
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script with sudo or as root."
  exit 1
fi

echo "=========================================="
echo "    Multimedia Codecs & Hardware Accel    "
echo "=========================================="

# Check if RPM Fusion Non-Free is enabled (required for freeworld packages)
if ! dnf repolist | grep -q "rpmfusion-nonfree"; then
  echo " Enabling RPM Fusion repositories "
  dnf install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm
fi

echo " Please select setup options:"

# 1. Full FFmpeg Swap
ENABLE_FFMPEG=false
echo -n "Swap ffmpeg-free with full ffmpeg (system-wide codec support)? [y/N]: "
read -r resp_ffmpeg
if [[ "$resp_ffmpeg" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  ENABLE_FFMPEG=true
fi

# 2. AMD VA-API Hardware Acceleration Swap
ENABLE_FREEWORLD_DRIVERS=false
echo -n "Install AMD Freeworld Mesa VA-API/VDPAU drivers (Hardware Acceleration)? [y/N]: "
read -r resp_freeworld
if [[ "$resp_freeworld" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  ENABLE_FREEWORLD_DRIVERS=true
fi

echo "---------------------------------------------------------"

if [ "$ENABLE_FFMPEG" = true ] || [ "$ENABLE_FREEWORLD_DRIVERS" = true ]; then

  echo " Refreshing DNF package metadata "
  dnf check-update || true

  if [ "$ENABLE_FFMPEG" = true ]; then
    echo " Swapping to full ffmpeg "
    dnf swap -y ffmpeg-free ffmpeg --allowerasing
  fi

  if [ "$ENABLE_FREEWORLD_DRIVERS" = true ]; then
    echo " Swapping to Mesa Freeworld drivers (64-bit & 32-bit) "
    dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
    dnf swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
    dnf install -y mesa-va-drivers-freeworld.i686 mesa-vdpau-drivers-freeworld.i686
  fi

  echo "=========================================="
  echo "       Multimedia Setup Completed!        "
  echo "=========================================="
else
  echo " No options selected. Skipping multimedia setup "
fi
