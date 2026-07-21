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
| `kde-minimal-install.sh` | Installs base Plasma desktop environment. | Installs core desktop (`plasma-desktop`), `konsole`, `dolphin`, and `dolphin-plugins`. |
| `kde-optional-apps.sh` | Installs optional native KDE utilities. | Interactive prompts to add tools like `kate`, `ark`, `okular`, or `gwenview`. |
| `multimedia.sh` | Installs system-wide audio/video codecs. | Enables RPM Fusion, replaces `ffmpeg-free` with full `ffmpeg`. |

## How to Use

### 1. Clone the repository
Boot into your minimal Fedora environment and run:
```bash
sudo dnf update -y && sudo dnf install git -y
git clone https://github.com/GLAJK/Fedora-KDE-Minimal-Install.git
cd Fedora-KDE-Minimal-Install
```
### 2. Run the Scripts in Order
Make sure the scripts are executable and run them using sudo:
```bash
chmod +x *.sh
```

1. Install AMD GPU Drivers & Vulkan libraries:
```bash
sudo ./amd-drivers.sh
```

2. Install Multimedia Codecs & Hardware Acceleration:
```bash
sudo ./multimedia.sh
```

3. Install Minimal KDE Plasma Desktop Environment:
```bash
sudo ./kde-minimal-install.sh
```

4. Install Applications & CLI Utilities (Optional):
```bash
sudo ./apps.sh
```

5. Install Core Utilities (Optional):
```bash
sudo ./kde-optional-apps.sh
```

### 3. Reboot
Once everything is completed, safely reboot your system to enter your clean, minimal KDE Plasma environment:
```bash
reboot
```
