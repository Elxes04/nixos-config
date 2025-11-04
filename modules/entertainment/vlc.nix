{ config, pkgs, ... }:

{
  # VLC - Versatile media player
  environment.systemPackages = with pkgs; [
    vlc
  ];
}