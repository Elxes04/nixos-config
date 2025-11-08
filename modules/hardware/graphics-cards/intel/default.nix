{ config, lib, pkgs, ... }:

{
  # Enable Intel GPU support
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver  # LIBVA_DRIVER_NAME=iHD (newer)
      vaapiIntel          # LIBVA_DRIVER_NAME=i965 (older but more stable)
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime # OpenCL support
    ];
  };

  # Enable 32-bit support for gaming/Steam
  hardware.graphics.enable32Bit = true;

  # Kernel modules for Intel GPU
  boot.kernelModules = [ "i915" ];

  # Intel GPU kernel parameters
  boot.kernelParams = [
    # Enable GuC/HuC firmware loading for better performance
    "i915.enable_guc=2"
  ];

  # Extra module parameters for Intel GPU
  boot.extraModprobeConfig = ''
    # Intel GPU options
    options i915 enable_guc=2
    options i915 enable_fbc=1
  '';

  # Environment variables for Intel GPU
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHd"; # Use Intel iHD driver for VA-API
  };
}
