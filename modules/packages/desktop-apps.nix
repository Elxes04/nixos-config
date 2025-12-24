{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs.unstable.kdePackages; [
    # KDE Applications
    discover
    kcalc
    kcharselect
    kclock
    kcolorchooser
    kolourpaint
    ksystemlog
    sddm-kcm
    kate
    konsole
    dolphin
    ark
    spectacle
    okular
    gwenview
    elisa
    isoimagewriter
    partitionmanager

    # Non-KDE applications
    pkgs.kdiff3
    pkgs.firefox
    pkgs.vlc
    pkgs.unstable.mpv
    pkgs.unstable.spotify
    pkgs.unstable.discord
    pkgs.unstable.telegram-desktop
    pkgs.libreoffice-qt
    pkgs.hunspell
    pkgs.hunspellDicts.it_IT
    pkgs.hunspellDicts.en_US
    pkgs.hardinfo2
    pkgs.gparted
    pkgs.bleachbit
    pkgs.qbittorrent
    pkgs.filezilla
    pkgs.p7zip
    pkgs.unzip
    pkgs.unrar
    pkgs.flameshot
    pkgs.obs-studio
    pkgs.wayland-utils
    pkgs.wl-clipboard
    pkgs.xclip
    pkgs.unstable.syncthing
    pkgs.keepassxc
    pkgs.unstable.gimp
    pkgs.unstable.inkscape
    pkgs.iotop
    pkgs.iftop
    pkgs.nethogs
  ];
}
