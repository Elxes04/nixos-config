{ config, pkgs, lib, ... }:

{
  imports = [
    ../hardware-configuration.nix

    # System modules
    ../modules/system/base.nix
    ../modules/system/network.nix
    ../modules/system/users.nix
    ../modules/desktop/pipewire.nix

    # Hardware - WiFi Cards (uncomment the one matching your WiFi card)
    ../modules/hardware/wifi-cards/intel
    # ../modules/hardware/wifi-cards/mediatek
    # ../modules/hardware/wifi-cards/broadcom
    # ../modules/hardware/wifi-cards/realtek

    # Hardware - Graphics Cards (uncomment the one matching your GPU)
    # ../modules/hardware/graphics-cards/intel
    # ../modules/hardware/graphics-cards/amd
    # ../modules/hardware/graphics-cards/nvidia

    # Desktop environment
    ../modules/desktop-environments/gnome.nix
    # ../modules/desktop-environments/plasma.nix
    # ../modules/desktop-environments/xfce.nix

    # Applications
    ../modules/desktop/flatpak.nix
    ../modules/apps/firefox.nix
    ../modules/apps/handbrake-custom.nix
    ../modules/apps/steam.nix
    ../modules/apps/telegram.nix
    ../modules/apps/vscode.nix

    # Development tools
    ../modules/development/docker.nix

    # Creative applications
    ../modules/creative/gimp.nix
    ../modules/creative/krita.nix
    ../modules/creative/obs-studio.nix

    # Tools
    ../modules/tools/btop.nix
    ../modules/tools/libreoffice.nix
    ../modules/tools/filezilla.nix

    # Entertainment
    ../modules/entertainment/discord.nix
    ../modules/entertainment/vlc.nix
    ../modules/entertainment/mpv.nix
  ];

  system.stateVersion = "25.05";
}
