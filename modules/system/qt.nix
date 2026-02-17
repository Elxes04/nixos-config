{ config, pkgs, inputs, ... }:

{
  # Qt configuration
  qt = {
    enable = true;
    platformTheme = "kde";
  };

  # Ensure Qt packages
  environment.systemPackages = [
    pkgs.libsForQt5.qt5.qtwayland
    pkgs.kdePackages.qtwayland
  ];
}
