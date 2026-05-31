{ config, pkgs, ... }:

{
  programs.nix-index = {
    enable = true;
    enableBashIntegration = true;
  };
}
