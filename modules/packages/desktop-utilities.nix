{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    p7zip
    unzip
    unrar
    file-roller
    filezilla
    gparted
    gnome-disk-utility
    gnome-software
    gnome-tweaks
    bleachbit
    flameshot
    wayland-utils
    wl-clipboard
    xclip
    alacritty
    kitty
    nautilus
    gnome-text-editor
    zenity
    xwayland-satellite
    mission-center
    localsend
    ydotool
  ];
}
