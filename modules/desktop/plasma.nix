{ config, pkgs, ... }:

{
  # Enable Plasma
  services.desktopManager.plasma6.enable = true;
  services.flatpak.enable = true;

# Default display manager for Plasma
services.displayManager.sddm = {
  enable = true;
  
# To use Wayland (Experimental for SDDM)
wayland.enable = true;
};

# Optionally enable xserver
services.xserver.enable = true;
}

