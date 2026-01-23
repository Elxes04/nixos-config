{ config, pkgs, ... }:

{
  services = {
    desktopManager.cosmic.enable = true;

    displayManager.cosmic-greeter.enable = true;

    xrdp = {
      enable = true;
      defaultWindowManager = "cosmic";
      openFirewall = true;
    };

    flatpak.enable = true;
    printing.enable = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Disable libadwaita theming in Firefox to avoid conflicts with COSMIC theming
  programs.firefox.preferences = {
    "widget.gtk.libadwaita-colors.enabled" = false;
  };

  # Use unstable for COSMIC components
  environment.systemPackages = with pkgs.unstable; [
    cosmic-applets
    cosmic-panel
    cosmic-session
  ];
}

