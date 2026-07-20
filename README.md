# Fedora KDE Minimal Install

Lightweight, debloated Fedora KDE Plasma setup scripts optimized for AMD systems. Get a fast, modern desktop without the bloat.

## Features
* **Interactive Control:** Choose what to install or remove via clean terminal prompts.
* **True Minimal KDE:** Installs only the bare essentials without bundled games, office suites, or excess background services.
* **AMD Optimized:** Configures modern AMD GPU firmware, Mesa, and Vulkan drivers out of the box.

## Prerequisites
* A fresh install using the **Fedora Everything ISO** (select `Standard and Common NetworkManager Submodules` under `Fedora Custom Operating System`).
* An **AMD CPU/GPU** configuration.
* An active internet connection.

## Scripts

| Script | Purpose | Notes |
| :--- | :--- | :--- |
| `amd-drivers.sh` | Sets up AMD GPU drivers and media libraries. | Installs 64-bit and 32-bit drivers for Steam gaming. |
| `apps.sh` | Installs essential non-KDE applications and CLI utilities. | Interactive setup for apps and tools like `brave-origin`, `bat`, `eza`, `fastfetch`, `steam`.  |
| `kde-minimal-install.sh` | Installs base Plasma desktop environment. | Removes leftover bloat (`plasma-discover`, `kdeconnect`, `khelpcenter`). |
| `kde-optional-apps.sh` | Installs optional native KDE utilities. | Interactive prompts to add tools like `kate`, `ark`, `okular`, or `gwenview`. |

## How to Use

### 1. Clone the repository
Boot into your minimal Fedora environment and run:
```bash
sudo dnf update -y && sudo dnf install git -y
git clone https://github.com/GLAJK/Fedora-KDE-Minimal-Install.git
cd Fedora-KDE-Minimal-Install
```
