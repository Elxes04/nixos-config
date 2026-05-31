{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    unstable.dms-shell
  ];

  programs.dms-shell.enable = true;
  services.displayManager.dms-greeter =
 {
  enable = true;
  compositor.name = "niri";
  configHome = "/home/elxes";
 };
}
