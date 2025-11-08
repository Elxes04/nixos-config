{ config, lib, pkgs, ... }:

let
  # Custom HandBrake with native CPU optimizations
  handbrake-optimized = pkgs.handbrake.override {
    # Use native optimizations
    stdenv = pkgs.stdenvAdapters.impureUseNativeOptimizations pkgs.stdenv;
  };
  
  handbrake-native = handbrake-optimized.overrideAttrs (oldAttrs: {
    # Disable hardening to allow native CPU optimizations
    hardeningDisable = [ "all" ];
    
    preConfigure = ''
      ${oldAttrs.preConfigure or ""}
      
      echo "Building HandBrake with native CPU optimizations enabled"
    '';
    
    configureFlags = (oldAttrs.configureFlags or []) ++ [
      "--optimize=speed"
      "--enable-gtk"
      # Add specific encoder optimizations if needed
      # "--enable-qsv"  # Intel Quick Sync (if you have Intel GPU)
      # "--enable-nvenc" # NVIDIA encoding (if you have NVIDIA GPU)
    ];
    
    # Ensure proper build type
    cmakeFlags = (oldAttrs.cmakeFlags or []) ++ [
      "-DCMAKE_BUILD_TYPE=Release"
    ];
  });
in
{
  environment.systemPackages = [
    handbrake-native
  ];
}
