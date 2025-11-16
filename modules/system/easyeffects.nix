{ config, pkgs, ... }:

{
  # EasyEffects - Audio effects for PipeWire
  environment.systemPackages = with pkgs; [
    easyeffects
  ];

  # Enable required services for EasyEffects
  services.pipewire.enable = true;
}
