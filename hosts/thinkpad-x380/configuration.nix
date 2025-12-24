{ config, pkgs, lib, ... }:

{
  # Hostname
  networking.hostName = "thinkpad-x380";

  # Enable flakes and nix command
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System version
  system.stateVersion = "25.05";
}
