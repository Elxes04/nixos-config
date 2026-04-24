{ config, pkgs, ... }:

{
  services.xserver.enable = true;

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.gnome.core-apps.enable = true;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;

  environment.systemPackages = with pkgs; [
    unstable.gnomeExtensions.arcmenu
    unstable.gnomeExtensions.appindicator
    unstable.gnomeExtensions.blur-my-shell
    unstable.gnomeExtensions.dash-to-dock
    unstable.gnomeExtensions.system-monitor
    unstable.gnomeExtensions.xwayland-indicator
  ];
}