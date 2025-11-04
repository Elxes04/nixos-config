{ config, pkgs, ... }:
{
  services.xserver.desktopManager.plasma6.enable = true;
  services.xserver.displayManager.sddm.enable = true;

  environment.systemPackages = with pkgs; [
    plasma6Packages.plasma-meta
  ];
}
