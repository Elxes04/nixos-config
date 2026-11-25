{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    unstable.discord
    telegram-desktop
    qbittorrent
    session-desktop
    thunderbird
  ];
}
