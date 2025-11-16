#!/usr/bin/env bash

# Hyprland Configuration Setup Script
# This script creates symlinks from the NixOS configuration to ~/.config

set -e

CONFIG_DIR="$HOME/Documents/Workspace/nixos/hyprland-config"
HYPR_DIR="$HOME/.config/hypr"
WAYBAR_DIR="$HOME/.config/waybar"
HYPRPAPER_DIR="$HOME/.config/hypr"
DUNST_DIR="$HOME/.config/dunst"
ROFI_DIR="$HOME/.config/rofi"
KITTY_DIR="$HOME/.config/kitty"
SWAYLOCK_DIR="$HOME/.config/swaylock"

echo "🚀 Setting up Hyprland configuration..."

# Create directories
echo "📁 Creating configuration directories..."
mkdir -p "$HYPR_DIR"
mkdir -p "$WAYBAR_DIR"
mkdir -p "$DUNST_DIR"
mkdir -p "$ROFI_DIR"
mkdir -p "$KITTY_DIR"
mkdir -p "$SWAYLOCK_DIR"
mkdir -p "$HOME/Pictures/Wallpapers"
mkdir -p "$HOME/Pictures/Screenshots"
mkdir -p "$HOME/Videos"

# Create symlinks for Hyprland configs
echo "🔗 Creating symlinks for Hyprland..."
ln -sf "$CONFIG_DIR/hyprland/hyprland.conf" "$HYPR_DIR/hyprland.conf"
ln -sf "$CONFIG_DIR/hyprland/style.conf" "$HYPR_DIR/style.conf"
ln -sf "$CONFIG_DIR/hyprland/monitors.conf" "$HYPR_DIR/monitors.conf"
ln -sf "$CONFIG_DIR/hyprland/workspaces.conf" "$HYPR_DIR/workspaces.conf"
ln -sf "$CONFIG_DIR/hyprland/binds.conf" "$HYPR_DIR/binds.conf"
ln -sf "$CONFIG_DIR/hyprland/rules.conf" "$HYPR_DIR/rules.conf"
ln -sf "$CONFIG_DIR/hyprland/autostart.conf" "$HYPR_DIR/autostart.conf"
ln -sf "$CONFIG_DIR/hyprpaper/hyprpaper.conf" "$HYPR_DIR/hyprpaper.conf"

# Create symlinks for Waybar configs
echo "🔗 Creating symlinks for Waybar..."
ln -sf "$CONFIG_DIR/waybar/config.json" "$WAYBAR_DIR/config"
ln -sf "$CONFIG_DIR/waybar/style.css" "$WAYBAR_DIR/style.css"

# Create symlinks for Dunst
echo "🔗 Creating symlinks for Dunst..."
ln -sf "$CONFIG_DIR/dunst/dunstrc" "$DUNST_DIR/dunstrc"

# Create symlinks for Rofi
echo "🔗 Creating symlinks for Rofi..."
ln -sf "$CONFIG_DIR/rofi/config.rasi" "$ROFI_DIR/config.rasi"

# Create symlinks for Kitty
echo "🔗 Creating symlinks for Kitty..."
ln -sf "$CONFIG_DIR/kitty/kitty.conf" "$KITTY_DIR/kitty.conf"

# Create symlinks for Swaylock
echo "🔗 Creating symlinks for Swaylock..."
ln -sf "$CONFIG_DIR/swaylock/config" "$SWAYLOCK_DIR/config"

echo "✅ Configuration setup complete!"
echo ""
echo "📝 Next steps:"
echo "  1. Add a wallpaper to ~/Pictures/Wallpapers/wallpaper.jpg"
echo "  2. Edit monitors.conf for your monitor setup"
echo "  3. Enable Hyprland in your NixOS configuration"
echo "  4. Rebuild with: sudo nixos-rebuild switch --flake .#nixos"
echo ""
echo "🎉 Enjoy Hyprland!"
