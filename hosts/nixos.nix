{ config, pkgs, lib, ... }:

{
  imports = [
    ../hardware-configuration.nix

    # System modules
    ../modules/system/base.nix
    ../modules/system/network.nix
    ../modules/system/users.nix

    # Desktop environment modules
    ../modules/desktop/gnome.nix
    ../modules/desktop/pipewire.nix
    ../modules/desktop/flatpak.nix

    # Applications
    ../modules/apps/firefox.nix
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

    # Entertainment
    ../modules/entertainment/discord.nix
    ../modules/entertainment/vlc.nix
  ];

  system.stateVersion = "25.05";
}
