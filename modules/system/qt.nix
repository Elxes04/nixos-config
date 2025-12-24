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
    # Darkly style packages can remain installed, but won't override KDE platform
    inputs.darkly.packages.${pkgs.system}.darkly-qt5
    inputs.darkly.packages.${pkgs.system}.darkly-qt6
  ];
}
