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

  browsers = import ./desktop-browsers.nix { inherit pkgs; };
  communications = import ./desktop-communications.nix { inherit pkgs; };
  multimedia = import ./desktop-multimedia.nix { inherit pkgs; };
  productivity = import ./desktop-productivity.nix { inherit pkgs; };
  utilities = import ./desktop-utilities.nix { inherit pkgs; };
  virtualization = import ./desktop-virtualization.nix { inherit pkgs; };
in
{
  # Waydroid system configuration
  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };

  # Package list configuration
  environment.systemPackages = with pkgs; (
    browsers
    ++ communications
    ++ multimedia
    ++ productivity
    ++ utilities
    ++ virtualization
    ++ [
      handbrake-native
      ffmpeg-native
      temurin-bin-25
    ]
  );
}