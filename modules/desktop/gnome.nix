{ config, pkgs, ... }:

{  
   services.displayManager.gdm.enable = true;

   services.desktopManager.gnome.enable = true;

   services.gnome.core-apps.enable = true;

   services.gnome.core-developer-tools.enable = false;

   services.gnome.games.enable = false;

   environment.systemPackages = with pkgs; [
      gnomeExtensions.arcmenu
      gnomeExtensions.appindicator
      gnomeExtensions.blur-my-shell
      gnomeExtensions.dash-to-dock
      gnomeExtensions.system-monitor
      gnomeExtensions.xwayland-indicator
   ];
}
