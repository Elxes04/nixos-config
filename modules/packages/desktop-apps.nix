{ config, pkgs, ... }:

let
  optimizedEnv = old: {
    env = (old.env or { }) // {
      NIX_CFLAGS_COMPILE = (old.env.NIX_CFLAGS_COMPILE or "") + " -O3 -march=native -mtune=native";
      NIX_CXXFLAGS_COMPILE = (old.env.NIX_CXXFLAGS_COMPILE or "") + " -O3 -march=native -mtune=native";
    };
  };

  handbrake-native = pkgs.handbrake.overrideAttrs (old: (optimizedEnv old) // { pname = "handbrake-native"; });
  ffmpeg-native = pkgs.ffmpeg.overrideAttrs (old: (optimizedEnv old) // { pname = "ffmpeg-native"; doCheck = false; });
in
{
  imports = [
    ./desktop-browsers.nix
    ./desktop-communications.nix
    ./desktop-multimedia.nix
    ./desktop-productivity.nix
    ./desktop-utilities.nix
    ./desktop-virtualization.nix
  ];

  # Waydroid system configuration
  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };

  # Package list configuration
  environment.systemPackages = [
    handbrake-native
    ffmpeg-native
    pkgs.temurin-bin-25
  ];
}