# Hyprland Configuration for NixOS

A modular and easily shareable Hyprland configuration for NixOS.

## 📁 Structure

```
hyprland-config/
├── hyprland/               # Hyprland window manager
│   ├── hyprland.conf      # Main configuration
│   ├── style.conf         # Color schemes and styling
│   ├── monitors.conf      # Monitor setup
│   ├── workspaces.conf    # Workspace assignments
│   ├── binds.conf         # Keybindings
│   ├── rules.conf         # Window rules
│   └── autostart.conf     # Autostart applications
├── waybar/                # Status bar
│   ├── config.json        # Waybar configuration
│   └── style.css          # Waybar styling
├── hyprpaper/             # Wallpaper daemon
│   └── hyprpaper.conf     # Wallpaper configuration
├── dunst/                 # Notification daemon
│   └── dunstrc            # Dunst configuration
├── rofi/                  # Application launcher
│   └── config.rasi        # Rofi configuration
├── kitty/                 # Terminal emulator
│   └── kitty.conf         # Kitty configuration
├── swaylock/              # Screen locker
│   └── config             # Swaylock configuration
├── setup.sh               # Installation script
└── README.md              # This file
```

## 🚀 Installation

1. Enable Hyprland in your NixOS configuration:
   ```nix
   imports = [ ./modules/desktop-environments/hyprland.nix ];
   ```

2. Link the configuration files to your home directory:
   ```bash
   # Or simply run the setup script:
   ./hyprland-config/setup.sh
   ```
   
   The script will create symlinks for:
   - Hyprland configs → `~/.config/hypr/`
   - Waybar configs → `~/.config/waybar/`
   - Dunst config → `~/.config/dunst/`
   - Rofi config → `~/.config/rofi/`
   - Kitty config → `~/.config/kitty/`
   - Swaylock config → `~/.config/swaylock/`

3. Create wallpaper directory:
   ```bash
   mkdir -p ~/Pictures/Wallpapers
   # Add your wallpaper as ~/Pictures/Wallpapers/wallpaper.jpg
   ```

4. Rebuild your NixOS configuration:
   ```bash
   sudo nixos-rebuild switch --flake .#nixos
   ```

## ⌨️ Keybindings

| Key | Action |
|-----|--------|
| `SUPER + RETURN` | Open terminal (Kitty) |
| `SUPER + Q` | Close active window |
| `SUPER + M` | Exit Hyprland |
| `SUPER + E` | Open file manager (Nautilus) |
| `SUPER + V` | Toggle floating |
| `SUPER + D` | Open app launcher (Rofi) |
| `SUPER + F` | Toggle fullscreen |
| `SUPER + L` | Lock screen |
| `SUPER + C` | Open clipboard history |
| `SUPER + 1-9` | Switch to workspace 1-9 |
| `SUPER + SHIFT + 1-9` | Move window to workspace 1-9 |
| `SUPER + Arrow Keys` | Move focus |
| `SUPER + LMB` | Move window |
| `SUPER + RMB` | Resize window |
| `PRINT` | Screenshot selection |
| `SHIFT + PRINT` | Screenshot full screen |
| `SUPER + PRINT` | Screenshot to file |
| `XF86AudioRaiseVolume` | Volume up |
| `XF86AudioLowerVolume` | Volume down |
| `XF86MonBrightnessUp` | Brightness up |
| `XF86MonBrightnessDown` | Brightness down |

## 🎨 Customization

### Colors & Styling
Edit `hyprland/style.conf` to customize the color scheme or create your own.

### Monitors
Edit `hyprland/monitors.conf` to configure your monitor layout.

### Workspaces
Edit `hyprland/workspaces.conf` to assign workspaces to specific monitors.

### Keybindings
Edit `hyprland/binds.conf` to customize your keybindings.

### Window Rules
Edit `hyprland/rules.conf` to add window-specific rules (floating, opacity, workspace assignments).

### Autostart
Edit `hyprland/autostart.conf` to manage applications that start with Hyprland.

### Status Bar
- Edit `waybar/config.json` for Waybar modules and layout
- Edit `waybar/style.css` for Waybar theming

### Notifications
Edit `dunst/dunstrc` to customize notification appearance and behavior.

### App Launcher
Edit `rofi/config.rasi` to customize Rofi theme and behavior.

### Terminal
Edit `kitty/kitty.conf` to customize terminal colors, fonts, and keybindings.

### Screen Lock
Edit `swaylock/config` to customize lock screen appearance.

### Wallpaper
Edit `hyprpaper/hyprpaper.conf` for wallpaper settings.

## 📦 Included Packages

- **Window Manager**: Hyprland with XWayland support
- **Status Bar**: Waybar
- **App Launcher**: Rofi
- **Terminal**: Kitty
- **Notifications**: Dunst
- **Screenshots**: Grim + Slurp
- **Screen Recording**: wf-recorder
- **Clipboard**: wl-clipboard + cliphist
- **Screen Lock**: swaylock-effects
- **Idle Management**: swayidle
- **Wallpaper**: hyprpaper
- **File Manager**: Nautilus (GNOME Files)
- **Audio Control**: pavucontrol

All components are themed with the same "Cyber Synthwave" color scheme for a cohesive look.

## 🔧 Tips

1. **First Time Setup**: On first login, configure your monitors in `monitors.conf`
2. **Wallpaper**: Place your wallpaper at `~/Pictures/Wallpapers/wallpaper.jpg`
3. **Screenshot Directory**: Screenshots are saved to `~/Pictures/Screenshots/`
4. **Gaming**: Tearing is enabled for Steam games for better performance

## 📝 Notes

- Keyboard layout is set to Italian (`it`). Change in `hyprland.conf` if needed.
- Natural scrolling is enabled for touchpads
- Some window rules assign specific apps to workspaces (Firefox→2, VSCode→3, Discord→4, Steam→5)

## 🌐 Publishing to GitHub

This configuration is already structured to be shared on GitHub:

1. The configuration is self-contained in the `hyprland-config/` directory
2. All paths are relative or use standard user directories
3. No sensitive information is included
4. Clear documentation in this README

To share:
```bash
# From the nixos-config repository
git add hyprland-config/ modules/desktop-environments/hyprland.nix
git commit -m "Add Hyprland configuration"
git push
```

## 📚 Resources

- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Waybar Wiki](https://github.com/Alexays/Waybar/wiki)
- [NixOS Wiki - Hyprland](https://nixos.wiki/wiki/Hyprland)
