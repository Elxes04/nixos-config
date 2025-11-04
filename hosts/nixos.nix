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
    ../modules/apps/firefox.nix
    ../modules/apps/vscode.nix
    ../modules/apps/telegram.nix
    ../modules/apps/steam.nix
    
    # Creative tools
    ../modules/creative/krita.nix
    ../modules/creative/obs-studio.nix
  ];

  system.stateVersion = "25.05";
}
