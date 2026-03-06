{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    vlc
    unstable.mpv
    unstable.discord
    unstable.telegram-desktop
    libreoffice-fresh
    hunspell
    hunspellDicts.it_IT
    hunspellDicts.en_US
    gparted
    gnome-tweaks
    bleachbit
    mission-center
    qbittorrent
    filezilla
    p7zip
    unzip
    unrar
    file-roller
    gnome-disk-utility
    gnome-software
    flameshot
    obs-studio
    wayland-utils
    wl-clipboard
    xclip
    unstable.syncthing
    keepassxc
    unstable.gimp
    virt-manager
    iotop
    iftop
    nethogs
  ];
}

