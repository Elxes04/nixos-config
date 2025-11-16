# Hyprland Configuration for NixOS

A modular and easily shareable Hyprland configuration for NixOS with ThinkPad-inspired aesthetics.

## 🎨 Theme

**ThinkPad Classic** - Minimalist design featuring the iconic ThinkPad black and red color scheme:
- Primary: Red (#ee1111)
- Accent: Bright Red (#ff3333)
- Critical: Pink Red (#ff0055)
- Background: Deep Black
- Clean, borderless UI elements with a distinctive red accent line

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
│   ├── style.css          # Waybar styling (ThinkPad theme)
│   └── scripts/           # Custom scripts
│       ├── cpu-graph.sh   # CPU usage bar graph
│       └── mem-graph.sh   # Memory usage bar graph
├── hyprpaper/             # Wallpaper daemon
│   └── hyprpaper.conf     # Wallpaper configuration
├── dunst/                 # Notification daemon
│   └── dunstrc            # Dunst configuration (ThinkPad theme)
├── rofi/                  # Application launcher
│   └── config.rasi        # Rofi configuration (ThinkPad theme)
├── kitty/                 # Terminal emulator
│   └── kitty.conf         # Kitty configuration (ThinkPad theme + cursor trail)
├── swaylock/              # Screen locker
│   └── config             # Swaylock configuration (ThinkPad theme)
├── wlogout/               # Logout menu
│   ├── layout             # Wlogout layout
│   └── style.css          # Wlogout styling (ThinkPad theme)
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
   - Waybar configs + scripts → `~/.config/waybar/`
   - Dunst config → `~/.config/dunst/`
   - Rofi config → `~/.config/rofi/`
   - Kitty config → `~/.config/kitty/`
   - Swaylock config → `~/.config/swaylock/`
   - Wlogout config → `~/.config/wlogout/`

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
| `SUPER + SHIFT + E` | Logout menu (wlogout) |
| `SUPER + SHIFT + C` | Color picker (hyprpicker) |
| `SUPER + C` | Open clipboard history |
| `SUPER + 1-9` | Switch to workspace 1-9 |
| `SUPER + SHIFT + 1-9` | Move window to workspace 1-9 |
| `SUPER + Arrow Keys` | Move focus |
| `SUPER + LMB` | Move window |
| `SUPER + RMB` | Resize window |
| `PRINT` | Screenshot selection → clipboard |
| `SHIFT + PRINT` | Screenshot full screen → clipboard |
| `SUPER + PRINT` | Screenshot selection → file |
| `SUPER + SHIFT + PRINT` | Screenshot full screen → file |
| `SUPER + SHIFT + R` | Start screen recording |
| `XF86AudioRaiseVolume` | Volume up |
| `XF86AudioLowerVolume` | Volume down |
| `XF86MonBrightnessUp` | Brightness up |
| `XF86MonBrightnessDown` | Brightness down |
| `3-finger swipe left/right` | Switch workspaces |

## ✨ Features

### Visual Enhancements
- **ThinkPad Theme**: Classic black and red color scheme across all components
- **Borderless Design**: Clean UI without distracting borders on status bar elements
- **CPU & Memory Graphs**: Real-time bar graphs showing system resource usage
- **Cursor Trail Effect**: Subtle light trail following cursor in terminal (Kitty)
- **Gradient Borders**: Smooth color transitions on active windows
- **Smooth Animations**: Custom bezier curves for fluid window movements

### Functionality
- **Auto-hiding Window Title**: Disappears when no windows are open
- **Hidden WiFi SSID**: Shows only signal strength, SSID in tooltip
- **Smart Screenshot Management**: Auto-creates directories, saves with timestamps
- **Clipboard History**: Persistent clipboard with search via Rofi
- **Night Light**: Automatic color temperature adjustment (wlsunset)
- **Idle Management**: Auto-lock after 5 minutes, screen off after 10 minutes
- **Workspace Gestures**: 3-finger swipe to change workspaces

### System Integration
- **No confirmation dialogs**: Kitty closes instantly without asking
- **Single waybar instance**: Managed by autostart to prevent duplicates
- **Proper symlink structure**: Easy updates via git pull + setup.sh

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
- **Status Bar**: Waybar with custom CPU/memory graphs
- **App Launcher**: Rofi (Wayland-native)
- **Terminal**: Kitty with cursor trail effect
- **Notifications**: Dunst
- **Screenshots**: Grim + Slurp + Swappy (annotation)
- **Screen Recording**: wf-recorder
- **Clipboard**: wl-clipboard + cliphist
- **Screen Lock**: swaylock-effects
- **Idle Management**: swayidle
- **Logout Menu**: wlogout
- **Wallpaper**: hyprpaper
- **Color Picker**: hyprpicker
- **Night Light**: wlsunset (auto color temperature)
- **Display Config**: kanshi (dynamic display management)
- **Brightness**: wluma (auto brightness), brightnessctl (manual)
- **File Manager**: Nautilus (GNOME Files)
- **Audio Control**: pavucontrol
- **Utilities**: wev (event viewer), wtype/ydotool (input simulation), imv (image viewer)

All components are themed with the ThinkPad color scheme for a cohesive look.

## 🔧 Tips

1. **First Time Setup**: On first login, configure your monitors in `monitors.conf`
2. **Wallpaper**: Place your wallpaper at `~/Pictures/Wallpapers/wallpaper.jpg`
3. **Screenshot Directory**: Screenshots are saved to `~/Pictures/Screenshots/` with timestamp
4. **Gaming**: Tearing is enabled for better performance in games
5. **Night Light**: wlsunset coordinates set for Rome, Italy - adjust in `autostart.conf` for your location
6. **Custom Graphs**: CPU and memory graphs update every 2-5 seconds automatically
7. **Logout Menu**: Press `SUPER + SHIFT + E` for shutdown/reboot/logout options

## 📝 Notes

- Keyboard layout is set to Italian (`it`). Change in `hyprland.conf` if needed.
- Natural scrolling is enabled for touchpads
- Tap-to-click enabled on touchpads
- Window swallowing enabled for Kitty (terminal disappears when opening GUI apps)
- Some window rules assign specific apps to workspaces (Firefox→2, VSCode→3, Discord→4, Steam→5)
- Waybar shows network signal strength without SSID (hover for details)
- Configuration optimized for ThinkPad X380 Yoga

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
