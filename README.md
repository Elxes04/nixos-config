# 🧊 Elxes' NixOS Configuration

> Complete and reproducible **NixOS** configuration with **Flakes** and **Home Manager**

![NixOS](https://img.shields.io/badge/NixOS-25.05-blue?logo=nixos&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-green)

## 🚀 Quick Start

1. **Clone this repository:**
   ```bash
   git clone https://github.com/Elxes04/nixos-config.git
   cd nixos-config
   ```

2. **Copy to system location:**
   ```bash
   sudo cp -r * /etc/nixos/
   ```

3. **Apply configuration:**
   ```bash
   cd /etc/nixos
   sudo nixos-rebuild switch --flake .#nixos
   ```

## 📦 Included Software

This configuration includes a comprehensive set of applications and tools:

### 🎨 **Creative Applications**
- **GIMP** - GNU Image Manipulation Program
- **Krita** - Digital painting and illustration
- **OBS Studio** - Screen recording and live streaming

### 💻 **Applications**
- **Firefox** - Web browser
- **Steam** - Gaming platform
- **Telegram** - Instant messaging
- **VS Code** - Code editor

### 🎮 **Games**
- **Minecraft** - Prism Launcher with multi-version Java support

### 🔧 **Development Tools**
- **Docker** - Containerization platform
- **Java** - JDK 8, 17, and 21 (for Minecraft and development)

### 🎮 **Entertainment**
- **Discord** - Voice and text chat
- **VLC** - Media player
- **mpv** - an open-source command line media player

### 🛠️ **System Tools**
- **Btop** - System resource monitor
- **LibreOffice** - Office suite
- **FileZilla client** - FTP/SFTP Client

### 🖥️ **Desktop Environment**
- **GNOME** - Desktop environment
- **Plasma** - Desktop Environment
- **XFCE** - Desktop Environment
- **Hyprland** - Tiling Wayland compositor with ThinkPad theme
- **PipeWire** - Audio system
- **Flatpak** - Application distribution

### ⚙️ **System Configuration**
- **Base system** - Essential system packages
- **Network** - NetworkManager and connectivity
- **Users** - User accounts and permissions

### 🔌 **Hardware Support**
- **WiFi Cards** - Intel, MediaTek, Broadcom, Realtek
- **Graphics Cards** - Intel, AMD, NVIDIA

Each hardware category is organized by manufacturer for easy navigation and selection.

## 📁 Repository Structure

```
nixos/
├── 📄 flake.nix              # Main flake configuration
├── 📁 hosts/                 # Host-specific configurations
│   └── nixos.nix            # Main host config
├── 📁 hyprland-config/       # Hyprland window manager setup
│   ├── hyprland/            # Hyprland configs
│   ├── waybar/              # Status bar with custom graphs
│   ├── dunst/               # Notifications
│   ├── rofi/                # App launcher
│   ├── kitty/               # Terminal
│   ├── swaylock/            # Screen locker
│   ├── wlogout/             # Logout menu
│   ├── hyprpaper/           # Wallpaper daemon
│   ├── setup.sh             # Auto-setup script
│   └── README.md            # Hyprland documentation
├── 📁 modules/               # Modular configurations
│   ├── 📁 apps/             # Core applications
│   ├── 📁 creative/         # Creative software
│   ├── 📁 development/      # Development tools
│   ├── 📁 entertainment/    # Entertainment apps
│   ├── 📁 games/            # Gaming applications
│   ├── 📁 tools/            # System utilities
│   ├── 📁 desktop/          # Desktop environment
│   ├── 📁 desktop-environments/ # DE configurations
│   │   ├── gnome.nix
│   │   ├── plasma.nix
│   │   ├── xfce.nix
│   │   └── hyprland.nix     # Hyprland system packages
│   ├── 📁 hardware/         # Hardware-specific configs
│   │   ├── 📁 graphics-cards/
│   │   │   ├── intel/
│   │   │   ├── amd/
│   │   │   └── nvidia/
│   │   └── 📁 wifi-cards/
│   │       ├── intel/
│   │       ├── mediatek/
│   │       ├── broadcom/
│   │       └── realtek/
│   └── 📁 system/           # System configuration
├── 📄 home.nix              # Home Manager configuration
└── 📄 README.md             # This file
```

## 🔧 Key Features

- ✅ **Complete Setup** - All essential applications included
- ✅ **Modular Design** - Each app in its own file
- ✅ **Hardware Support** - Pre-configured modules for various WiFi cards and GPUs
- ✅ **Multiple Desktop Environments** - GNOME, Plasma, XFCE, and Hyprland
- ✅ **Hyprland Configuration** - Complete tiling WM setup with ThinkPad theme
- ✅ **Flakes Support** - Reproducible builds
- ✅ **Home Manager** - User-level configuration
- ✅ **English Codebase** - Clean, documented code

## 🛠️ Customization

### Hardware Configuration

**Before first installation**, configure hardware modules in `hosts/nixos.nix`:

1. **Identify your hardware:**
   ```bash
   # Check WiFi card
   lspci | grep -i network
   
   # Check GPU
   lspci | grep -i vga
   ```

2. **Enable appropriate modules** in `hosts/nixos.nix`:
   ```nix
   imports = [
     # WiFi Cards - uncomment ONE that matches your card
     ../modules/hardware/wifi-cards/intel
     # ../modules/hardware/wifi-cards/mediatek
     # ../modules/hardware/wifi-cards/broadcom
     # ../modules/hardware/wifi-cards/realtek
     
     # Graphics Cards - uncomment ONE that matches your card
     # ../modules/hardware/graphics-cards/intel
     # ../modules/hardware/graphics-cards/amd
     # ../modules/hardware/graphics-cards/nvidia
   ];
   ```

See `modules/hardware/README.md` for detailed hardware documentation.

### Adding New Modules

1. **Create a new `.nix` file** in the appropriate category:
   ```nix
   # modules/tools/neofetch.nix
   { config, pkgs, ... }: {
     environment.systemPackages = with pkgs; [ neofetch ];
   }
   ```

2. **Add it to the imports** in `hosts/nixos.nix`:
   ```nix
   imports = [
     # ... other imports ...
     ../modules/tools/neofetch.nix
   ];
   ```

3. **Rebuild the system:**
   ```bash
   sudo nixos-rebuild switch --flake .#nixos
   ```

## 🎯 Philosophy

### Removing Modules

Simply remove the import line from `hosts/nixos.nix` and rebuild.

## 🎨 Hyprland Setup

This repository includes a complete **Hyprland** configuration with a ThinkPad-inspired theme.

### Features
- � **ThinkPad Classic Theme** - Black and red color scheme
- 📊 **System Graphs** - Real-time CPU and memory usage bars
- ✨ **Modern Effects** - Cursor trails, smooth animations, blur effects
- 🔧 **Complete Toolset** - Waybar, Rofi, Dunst, Kitty, all themed consistently
- 📱 **Gesture Support** - 3-finger swipe to change workspaces
- 🌙 **Night Light** - Automatic color temperature adjustment
- 🖼️ **Smart UI** - Auto-hiding elements, borderless design

### Quick Setup
```bash
# Enable Hyprland in hosts/nixos.nix
imports = [
  ../modules/desktop-environments/hyprland.nix
];

# Run the setup script
cd hyprland-config
./setup.sh

# Rebuild system
sudo nixos-rebuild switch --flake .#nixos

# Select Hyprland at login screen
```

For detailed configuration and keybindings, see [`hyprland-config/README.md`](hyprland-config/README.md).

## 🛠️ Customization

This configuration follows these principles:

- **Completeness** - All essential tools included by default
- **Modularity** - One app per file for easy maintenance
- **Simplicity** - Easy to understand and modify
- **Reproducibility** - Same result everywhere

## 📦 Installation Requirements

- NixOS 25.05 or later
- Flakes support enabled
- Internet connection for package downloads

## 🤝 Contributing

Feel free to:
- 🍴 Fork this repository
- 🐛 Report issues
- 💡 Suggest improvements
- 📝 Submit pull requests

## 📄 License

This configuration is released under the MIT License. See [LICENSE](LICENSE) for details.

---

<div align="center">

**Made with ❤️ for the NixOS community**

[⭐ Star this repo](https://github.com/Elxes04/nixos-config) • [🐛 Report Issue](https://github.com/Elxes04/nixos-config/issues) • [💬 Discussions](https://github.com/Elxes04/nixos-config/discussions)

</div>