{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    unstable.firefox
  ];
}
