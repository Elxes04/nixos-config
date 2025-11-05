{ config, pkgs, ... }:

{
  # mpv - an open-source command line media player
  environment.systemPackages = with pkgs; [
    mpv
  ];
}