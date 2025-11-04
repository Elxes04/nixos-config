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

### 🔧 **Development Tools**
- **Docker** - Containerization platform

### 🎮 **Entertainment**
- **Discord** - Voice and text chat
- **VLC** - Media player

### 🛠️ **System Tools**
- **Btop** - System resource monitor
- **LibreOffice** - Office suite

### 🖥️ **Desktop Environment**
- **GNOME** - Desktop environment
- **PipeWire** - Audio system
- **Flatpak** - Application distribution

### ⚙️ **System Configuration**
- **Base system** - Essential system packages
- **Network** - NetworkManager and connectivity
- **Users** - User accounts and permissions

## 📁 Repository Structure

```
nixos/
├── 📄 flake.nix              # Main flake configuration
├── 📁 hosts/                 # Host-specific configurations
│   └── nixos.nix            # Main host config
├── 📁 modules/               # Modular configurations
│   ├── 📁 apps/             # Core applications
│   ├── 📁 creative/         # Creative software
│   ├── 📁 development/      # Development tools
│   ├── 📁 entertainment/    # Entertainment apps
│   ├── 📁 tools/            # System utilities
│   ├── 📁 desktop/          # Desktop environment
│   └── 📁 system/           # System configuration
├── 📄 home.nix              # Home Manager configuration
└── 📄 README.md             # This file
```

## 🔧 Key Features

- ✅ **Complete Setup** - All essential applications included
- ✅ **Modular Design** - Each app in its own file
- ✅ **Flakes Support** - Reproducible builds
- ✅ **Home Manager** - User-level configuration
- ✅ **GNOME Desktop** - Modern desktop environment
- ✅ **English Codebase** - Clean, documented code

## 🛠️ Customization

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

### Removing Modules

Simply remove the import line from `hosts/nixos.nix` and rebuild.


## 🎯 Philosophy

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