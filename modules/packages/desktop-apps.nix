{ config, pkgs, ... }:

let
  optimizedEnv = old: {
    env = (old.env or {}) // {
      NIX_CFLAGS_COMPILE = (old.env.NIX_CFLAGS_COMPILE or "") + " -O3 -march=native -mtune=native";
      NIX_CXXFLAGS_COMPILE = (old.env.NIX_CXXFLAGS_COMPILE or "") + " -O3 -march=native -mtune=native";
    };
  };

  handbrake-native = pkgs.handbrake.overrideAttrs (old: (optimizedEnv old) // { pname = "handbrake-native"; });
  ffmpeg-native = pkgs.ffmpeg.overrideAttrs (old: (optimizedEnv old) // { pname = "ffmpeg-native"; doCheck = false; });
in
{
  environment.systemPackages = with pkgs; [
    firefox
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
    handbrake-native
    ffmpeg-native
    wayland-utils
    wl-clipboard
    xclip
    keepassxc
    unstable.gimp
    virt-manager
    easyeffects
    virt-viewer
    alacritty
    nautilus
  ];
}

