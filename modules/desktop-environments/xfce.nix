{ config, pkgs, ... }:
{
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.lightdm.enable = true;

  environment.systemPackages = with pkgs; [
    xfce.thunar
  ];
}
