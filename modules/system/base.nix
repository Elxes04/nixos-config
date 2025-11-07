{ config, pkgs, lib, ... }:

{
  imports = [
    ../hardware-configuration.nix

    # System modules
    ../modules/system/base.nix
    ../modules/system/network.nix
    ../modules/system/users.nix
    ../modules/desktop/pipewire.nix

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
