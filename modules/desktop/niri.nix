{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    unstable.niri
  ];

  programs.niri.enable = true;
}