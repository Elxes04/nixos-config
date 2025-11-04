{ config, pkgs, ... }:

{
  # OBS Studio - Screen recording and streaming
  environment.systemPackages = with pkgs; [
    obs-studio
  ];

  # Enable hardware acceleration (updated for NixOS 25.05)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}