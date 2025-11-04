# 🧊 Elxes' NixOS Configuration

> Modular and reproducible **NixOS** configuration with **Flakes** and **Home Manager**

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

3. **Use the interactive module selector:**
   ```bash
   cd /etc/nixos
   sudo ./select-modules.sh
   ```

4. **Apply configuration:**
   ```bash
   sudo nixos-rebuild switch --flake .#nixos
   ```

## 🎛️ Interactive Module Management

This configuration features a **TUI (Text User Interface)** script for easy module management:

```bash
sudo ./select-modules.sh
```

### Available Module Categories:

- 🎨 **Creative:** Krita, GIMP, OBS Studio
- 💻 **Development:** Docker, VSCode  
- 🎮 **Entertainment:** Discord, VLC
- 🛠️ **Tools:** Btop, LibreOffice
- 🖥️ **Apps:** Firefox, Steam, Telegram

Simply use commands like:
```
Command: toggle creative/krita
Command: toggle tools/btop
Command: apply
```

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
├── 🎛️ select-modules.sh      # Interactive module selector
└── 📄 README.md             # This file
```

## 🔧 Key Features

- ✅ **Modular Design** - Each app in its own file
- ✅ **Interactive TUI** - Easy module selection
- ✅ **Flakes Support** - Reproducible builds
- ✅ **Home Manager** - User-level configuration
- ✅ **Auto Backup** - Safe configuration changes
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

2. **Use the TUI script** to activate it:
   ```bash
   sudo ./select-modules.sh
   toggle tools/neofetch
   apply
   ```


## 🎯 Philosophy

This configuration follows these principles:

- **Modularity** - One app per file
- **Simplicity** - Easy to understand and modify
- **Reproducibility** - Same result everywhere
- **Interactivity** - User-friendly management tools

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