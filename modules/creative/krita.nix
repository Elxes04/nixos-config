{ config, pkgs, ... }:

{
  # Krita - Digital painting application
  environment.systemPackages = with pkgs; [
    krita
  ];
}