{ config, lib, pkgs, ... }:

{
  # Enable NVIDIA GPU support
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
  };

  # Enable 32-bit support for gaming/Steam
  hardware.graphics.enable32Bit = true;

  # NVIDIA driver configuration
  hardware.nvidia = {
    # Modesetting is required
    modesetting.enable = true;

    # Enable power management (experimental, can cause sleep/suspend issues)
    powerManagement.enable = false;
    
    # Fine-grained power management (Turing and newer)
    powerManagement.finegrained = false;

    # Use the open source kernel module (for newer GPUs)
    # Set to false for proprietary driver
    open = false;

    # Enable the Nvidia settings menu
    nvidiaSettings = true;

    # Select the appropriate driver version
    # Options: stable, beta, legacy_470, legacy_390, legacy_340
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # NVIDIA kernel parameters
  boot.kernelParams = [
    # Enable DRM kernel mode setting
    "nvidia-drm.modeset=1"
    # Disable framebuffer compression (can cause issues)
    "nvidia.NVreg_EnablePCIeGen3=1"
  ];

  # Extra module parameters for NVIDIA GPU
  boot.extraModprobeConfig = ''
    # NVIDIA options
    options nvidia NVreg_UsePageAttributeTable=1
    options nvidia NVreg_InitializeSystemMemoryAllocations=0
    options nvidia NVreg_DynamicPowerManagement=0x02
  '';

  # Hardware video acceleration
  hardware.enableRedistributableFirmware = true;

  # Environment variables for NVIDIA GPU
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1"; # Fix for Wayland cursor issues
  };
}
