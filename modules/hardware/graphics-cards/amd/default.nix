{ config, lib, pkgs, ... }:

{
  # Enable AMD GPU support
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd      # OpenCL support
      amdvlk                     # Vulkan driver (AMD official)
      # mesa.drivers             # Alternative open-source Vulkan (RADV)
    ];
  };

  # Enable 32-bit support for gaming/Steam
  hardware.graphics.enable32Bit = true;
  hardware.graphics.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  # Kernel modules for AMD GPU
  boot.kernelModules = [ "amdgpu" ];

  # AMD GPU kernel parameters
  boot.kernelParams = [
    # Enable AMD GPU driver early
    "amdgpu.dc=1"
    # Enable AMD GPU power management
    "amdgpu.ppfeaturemask=0xffffffff"
  ];

  # Extra module parameters for AMD GPU
  boot.extraModprobeConfig = ''
    # AMD GPU options
    options amdgpu dc=1
    options amdgpu ppfeaturemask=0xffffffff
  '';

  # Environment variables for AMD GPU
  environment.sessionVariables = {
    # Use RADV (Mesa) Vulkan driver by default (better performance in most cases)
    # AMD_VULKAN_ICD = "RADV";
    # Or use AMDVLK (AMD official)
    AMD_VULKAN_ICD = "AMDVLK";
  };

  # Hardware video acceleration
  hardware.enableRedistributableFirmware = true;
}
