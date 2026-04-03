{ config, pkgs, lib, ... }:

let
  beammp-launcher = pkgs.stdenv.mkDerivation rec {
    pname = "beammp-launcher";
    version = "latest";

    src = pkgs.fetchFromGitHub {
      owner = "BeamMP";
      repo = "BeamMP-Launcher";
      rev = "master";
      sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };

    nativeBuildInputs = with pkgs; [
      cmake
      git
      pkg-config
    ];

    buildInputs = with pkgs; [
      curl
      zip
      unzip
    ];

    buildPhase = ''
      mkdir build
      cd build
      cmake .. \
        -DCMAKE_BUILD_TYPE=Release
      make -j$NIX_BUILD_CORES
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp build/BeamMP-Launcher $out/bin/
    '';
  };

in
{
  options.beammp.enable = lib.mkEnableOption "Enable BeamMP build environment";

  config = lib.mkIf config.beammp.enable {
    environment.systemPackages = [
      beammp-launcher

      (pkgs.writeShellScriptBin "beammp-build" ''
        echo "Building BeamMP Launcher..."
        nix build .#beammp-launcher
      '')
    ];
  };
}