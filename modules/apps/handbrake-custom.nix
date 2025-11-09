{ config, lib, pkgs, ... }:

let
  # Optimized stdenv for all packages
  optimizedStdenv = pkgs.stdenvAdapters.impureUseNativeOptimizations pkgs.stdenv;
  
  # x264 with native optimizations
  x264-optimized = (pkgs.x264.override {
    stdenv = optimizedStdenv;
  }).overrideAttrs (oldAttrs: {
    hardeningDisable = [ "all" ];
    configureFlags = (oldAttrs.configureFlags or []) ++ [
      "--enable-strip"
    ];
  });
  
  # x265 with native optimizations
  x265-optimized = (pkgs.x265.override {
    stdenv = optimizedStdenv;
  }).overrideAttrs (oldAttrs: {
    hardeningDisable = [ "all" ];
    cmakeFlags = (oldAttrs.cmakeFlags or []) ++ [
      "-DCMAKE_BUILD_TYPE=Release"
      "-DENABLE_AGGRESSIVE_CHECKS=OFF"
    ];
  });
  
  # SVT-AV1 with native optimizations
  svt-av1-optimized = (pkgs.svt-av1.override {
    stdenv = optimizedStdenv;
  }).overrideAttrs (oldAttrs: {
    hardeningDisable = [ "all" ];
    cmakeFlags = (oldAttrs.cmakeFlags or []) ++ [
      "-DCMAKE_BUILD_TYPE=Release"
      "-DBUILD_SHARED_LIBS=ON"
    ];
  });
  
  # FFmpeg with optimized encoders
  ffmpeg-optimized = (pkgs.ffmpeg-full.override {
    stdenv = optimizedStdenv;
    x264 = x264-optimized;
    x265 = x265-optimized;
    svt-av1 = svt-av1-optimized;
  }).overrideAttrs (oldAttrs: {
    hardeningDisable = [ "all" ];
    configureFlags = (oldAttrs.configureFlags or []) ++ [
      "--enable-gpl"
      "--enable-version3"
      "--disable-debug"
      "--enable-optimizations"
      "--enable-runtime-cpudetect"
      "--enable-libx264"
      "--enable-libx265"
      "--enable-libsvtav1"
    ];
  });
  
  # HandBrake with all optimized dependencies
  handbrake-optimized = pkgs.handbrake.override {
    stdenv = optimizedStdenv;
    ffmpeg_7-full = ffmpeg-optimized;
    x264 = x264-optimized;
    svt-av1 = svt-av1-optimized;
  };
  
  handbrake-native = handbrake-optimized.overrideAttrs (oldAttrs: {
    hardeningDisable = [ "all" ];
    
    preConfigure = ''
      ${oldAttrs.preConfigure or ""}
      
      echo "========================================"
      echo "Building HandBrake with NATIVE CPU optimizations"
      echo "Including optimized: FFmpeg, x264, x265, SVT-AV1"
      echo "Configure flags: --optimize=speed --enable-gtk"
      echo "CMake: CMAKE_BUILD_TYPE=Release"
      echo "========================================"
    '';
    
    configureFlags = (oldAttrs.configureFlags or []) ++ [
      "--optimize=speed"
      "--enable-gtk"
      # Add specific encoder optimizations if needed
      # "--enable-qsv"  # Intel Quick Sync (if you have Intel GPU)
      # "--enable-nvenc" # NVIDIA encoding (if you have NVIDIA GPU)
    ];
    
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
