{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # COSMIC Applications (from unstable)
    unstable.cosmic-files
    unstable.cosmic-settings

    # Non-COSMIC applications
    firefox
    vlc
    unstable.mpv
    unstable.spotify
    unstable.discord
    unstable.telegram-desktop
    unstable.amnezia-vpn
    libreoffice-fresh
    hunspell
    hunspellDicts.it_IT
    hunspellDicts.en_US
    hardinfo2
    gparted
    bleachbit
    mission-center
    qbittorrent
    filezilla
    p7zip
    unzip
    unrar
    file-roller
    gnome-disk-utility
    resources
    flameshot
    obs-studio
    wayland-utils
    wl-clipboard
    xclip
    unstable.syncthing
    keepassxc
    unstable.gimp
    unstable.inkscape
    virt-manager
    iotop
    iftop
    nethogs
  ];
}

