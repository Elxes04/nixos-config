{ config, pkgs, ... }:

{
  # Btop - Modern system monitor
  environment.systemPackages = with pkgs; [
    btop
  ];
}