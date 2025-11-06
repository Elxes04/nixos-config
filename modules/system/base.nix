{ config, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 3;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Rome";
  i18n.defaultLocale = "en_US.UTF-8";

  swapDevices = [ ];
  zramSwap.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Optimize Nix store automatically
  nix.optimise = {
    automatic = true;
    dates = [ "03:45" ];
  };

  environment.systemPackages = with pkgs; [
    # Essential system tools
    git
    wget
    curl
    tree
    fastfetch
    flatpak
  ];

  security.sudo.enable = true;
}
