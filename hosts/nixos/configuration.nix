{ config, pkgs, lib, ... }:

{
  networking.hostName = "nixos";

  programs.dms-greeter = {
    enable = true;

    compositor.name = "niri";

    # Use DMS configuration for greeter theming
    configHome = "/home/elxes";
  };
}
