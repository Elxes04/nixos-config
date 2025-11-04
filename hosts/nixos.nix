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

    # Applications and tools
    ../modules/system/users.nix
    ../modules/creative/krita.nix
    ../modules/desktop/gnome.nix
    ../modules/apps/firefox.nix
    ../modules/desktop/pipewire.nix
    ../modules/system/network.nix
    ../modules/apps/vscode.nix
    ../modules/apps/telegram.nix
    ../modules/apps/steam.nix
    ../modules/creative/obs-studio.nix
    ../modules/desktop/flatpak.nix
    ../modules/system/base.nix
  ];

  system.stateVersion = "25.05";
}
