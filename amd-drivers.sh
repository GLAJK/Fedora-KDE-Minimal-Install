#!/usr/bin/env bash

set -euo pipefail

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script with sudo or as root."
  exit 1
fi

echo "=========================================="
echo "       Fedora AMD Graphics Setup          "
echo "=========================================="

# Define base 64-bit AMD packages
PACKAGES=(
  amd-ucode-firmware
  amd-gpu-firmware
  mesa-dri-drivers
  mesa-va-drivers
  mesa-vulkan-drivers
  mesa-libOpenCL
  mesa-libEGL
  mesa-libGL
  mesa-libGLU
  libva
  mesa-demos
  vulkan-loader
  vulkan-tools
  xorg-x11-drv-amdgpu
)

# Prompt for 32-bit (i686) driver support
echo -n "Do you want to enable 32-bit (i686) graphics drivers for older 32-bit apps/games? [y/N]: "
read -r response

if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  echo " Adding 32-bit (i686) driver libraries "
  PACKAGES+=(
    mesa-dri-drivers.i686
    mesa-vulkan-drivers.i686
    mesa-libOpenCL.i686
    mesa-libEGL.i686
    mesa-libGL.i686
    vulkan-loader.i686
  )
fi

echo " Refreshing package metadata "
dnf check-update || true

echo " Installing AMD drivers and libraries "
dnf install -y "${PACKAGES[@]}"

echo "=========================================="
echo "    AMD Drivers Installed Successfully!   "
echo "=========================================="
