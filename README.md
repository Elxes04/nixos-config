# NixOS Configuration (Flakes)

A declarative NixOS configuration using Flakes for reproducible system setup. Includes modular system configuration, Niri window manager, DMS display manager, and Home Manager with organized user programs.

## 📁 Directory Structure

```
.
├── flake.nix                                  # Flake entry point and inputs
├── hardware-configuration.nix                 # Auto-generated hardware config
├── hosts/
│   └── nixos/configuration.nix               # Host-specific settings
├── modules/
│   ├── system/                                # System-level configuration
│   │   ├── host.nix                          # Hostname and networking
│   │   ├── nix.nix                           # Nix daemon settings
│   │   ├── graphics.nix                      # GPU drivers (Intel, NVIDIA)
│   │   ├── audio.nix                         # Audio (PulseAudio/PipeWire)
│   │   ├── state-version.nix                 # NixOS version tracking
│   │   ├── boot.nix                          # Boot configuration
│   │   ├── locale.nix                        # Timezone and locale
│   │   ├── networking.nix                    # Network configuration
│   │   ├── users.nix                         # User management
│   │   ├── filesystems.nix                   # Filesystem setup
│   │   ├── fonts.nix                         # System fonts
│   │   └── testvm.nix                        # VM-specific settings
│   ├── desktop/                               # Desktop environment modules
│   │   ├── niri.nix                          # Niri window manager (system)
│   │   └── dms.nix                           # DMS display manager
│   ├── games/
│   │   └── minecraft.nix                     # Minecraft runtime setup
│   └── packages/                              # Package groups
│       ├── gaming.nix                        # Gaming packages
│       ├── development.nix                   # Development tools
│       ├── flatpaks.nix                      # Flatpak configuration
│       └── desktop-apps.nix                  # Desktop applications
├── home/
│   ├── elxes.nix                             # Home Manager entry point
│   └── programs/                              # Modular user programs
│       ├── shell/
│       │   ├── zsh.nix                       # Shell + aliases
│       │   ├── starship.nix                  # Prompt configuration
│       │   └── zoxide.nix                    # Directory jumper
│       ├── dev/
│       │   ├── git.nix                       # Git settings
│       │   ├── neovim.nix                    # Text editor
│       │   └── nix-index.nix                 # Nix package finder
│       ├── cli/
│       │   ├── bat.nix                       # Cat replacement
│       │   ├── eza.nix                       # ls replacement
│       │   ├── fzf.nix                       # Fuzzy finder
│       │   ├── direnv.nix                    # Directory environment
│       │   └── tmux.nix                      # Terminal multiplexer
│       └── desktop/
│           ├── niri.nix                      # Niri config (home-manager)
│           └── dms.nix                       # DMS config (home-manager)
├── Makefile                                   # Build targets
├── fonts/                                     # Custom fonts
└── README.md                                  # This file
```

## 🖥️ Desktop Environment

### Niri Window Manager
- **Type**: Tiling window manager for Wayland
- **Keyboard Layouts**: English (US), Italian, Russian
- **Layout Switching**: Alt+Shift
- **Configuration**: `home/programs/desktop/niri.nix`
- **Key Features**:
  - Vim-style navigation (Super+HJKL)
  - 10 workspaces
  - Column-based layout
  - Customizable keybindings
  - Volume and brightness controls via media keys

### DMS Display Manager
- **Type**: Display manager with Wayland support
- **Compositor**: Niri
- **Configuration**: `modules/desktop/dms.nix` and `home/programs/desktop/dms.nix`

### Keyboard Layouts in Niri
- **US** (default)
- **Italian** (IT)
- **Russian** (RU)
- **Switch**: Alt+Shift to cycle through layouts

## 🛠️ Requirements

- **NixOS**: 26.05
- **Flakes**: Enabled (`nix-command` and `flakes` in experimental features)
- **Git**: For flake inputs

## 📝 Usage

### With Makefile

```bash
# Rebuild and switch to new configuration
make switch HOST=nixos

# Test new configuration without switching
make test HOST=nixos

# Set configuration for next boot
make boot HOST=nixos

# Update flake inputs
make update

# Check flake syntax
make check

# List system generations
make list-generations
```

### Direct Commands

```bash
# Rebuild and switch
sudo nixos-rebuild switch --flake .#nixos

# Rebuild and test
sudo nixos-rebuild test --flake .#nixos

# Update flake inputs
nix flake update

# Check flake
nix flake check
```

## 🔧 Home Manager Configuration

The Home Manager configuration is organized into modular files under `home/programs/`:

### Shell Programs
- **zsh**: Shell with powerlevel10k theme and custom aliases
- **starship**: Minimal prompt alternative
- **zoxide**: Directory navigation with history

### Development Tools
- **git**: Version control with custom aliases
- **neovim**: Default editor (vi/vim alias)
- **nix-index**: Quick package lookup

### CLI Utilities
- **bat**: Cat alternative with syntax highlighting
- **eza**: Modern ls replacement with git integration
- **fzf**: Fuzzy finder with zsh integration
- **direnv**: Automatic environment switching
- **tmux**: Terminal multiplexer with vim keybindings

### Desktop
- **niri**: Window manager configuration
- **dms**: Display manager configuration

## 🚀 Keyboard Shortcuts in Niri

| Action | Shortcut |
|--------|----------|
| Close window | Super+Q |
| Focus left/right | Super+H/L |
| Focus up/down | Super+K/J |
| Move window | Super+Shift+HJKL |
| Resize window | Super+Ctrl+HJKL |
| Workspace 1-9 | Super+1-9 |
| Move to workspace | Super+Shift+1-9 |
| Maximize window | Super+F |
| 50% width | Super+S |
| Cycle column width | Super+R |
| Terminal | Super+Return |
| App launcher | Super+Space |
| Screenshot (full) | Print |
| Screenshot (region) | Super+Print |
| Raise volume | XF86AudioRaiseVolume |
| Lower volume | XF86AudioLowerVolume |
| Mute | XF86AudioMute |
| Brightness up | XF86MonBrightnessUp |
| Brightness down | XF86MonBrightnessDown |

## 📦 Installed Packages

### Development
- VS Code (unstable)
- Lazygit, Lazydocker
- DBEaver, pgAdmin4
- Dive (Docker image explorer)
- Postman
- ripgrep, fd, tldr

### System Tools
- httpie
- fastfetch
- Nix utilities

### Gaming & Minecraft
- Minecraft Java runtime
- Gaming packages

## ⚙️ Important Notes

- **State Version**: `system.stateVersion` in `modules/system/state-version.nix` should match your NixOS installation to avoid unintended migrations
- **Username**: Default user is `elxes`. Update in `home/elxes.nix` and `flake.nix` if different
- **Hostname**: Default is `nixos`. Update flake.nix if using a different name
- **Hardware**: Check `hardware-configuration.nix` matches your system after fresh install

## 🐛 Troubleshooting

### Rebuild Fails
```bash
sudo nixos-rebuild switch --flake .#nixos --show-trace
```

### Niri Layout Issues
- Check if all keybindings are recognized: `niri msg binds`
- Verify keyboard layouts: `niri msg outputs`
- Check logs: `journalctl -xe`

### Home Manager Issues
```bash
# Force home-manager activation
home-manager switch --flake .#elxes
```

### Display Manager Won't Start
- Verify DMS is correctly enabled in `modules/desktop/dms.nix`
- Check systemd service logs: `journalctl -u display-manager -xe`

## 📚 References

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Niri Documentation](https://github.com/YaLTeR/niri)
- [Flakes Documentation](https://nixos.wiki/wiki/Flakes)
