{ config, pkgs, ... }:

{
  # GIMP - GNU Image Manipulation Program
  environment.systemPackages = with pkgs; [
    gimp
  ];
}