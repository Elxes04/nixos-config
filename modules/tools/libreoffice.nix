{ config, pkgs, ... }:

{
  # LibreOffice - Office suite
  environment.systemPackages = with pkgs; [
    libreoffice-fresh
  ];
}