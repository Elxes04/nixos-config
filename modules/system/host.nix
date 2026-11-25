{ config, pkgs, ... }:

{
  networking.hostName = "nixos";

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
  };

  hardware.enableRedistributableFirmware = true;
  services.power-profiles-daemon.enable = true;
}
