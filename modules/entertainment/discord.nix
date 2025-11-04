{ config, pkgs, ... }:

{
  # Discord - Voice and text chat
  environment.systemPackages = with pkgs; [
    discord
  ];
}