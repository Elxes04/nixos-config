{ config, pkgs, ... }:

{
  boot.kernelModules = [ "kvm-intel" "i915" "ntsync" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ intel-media-driver vulkan-loader vulkan-tools ];
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "intel" ];
    deviceSection = ''
      Option "DRI" "3"
      Option "TearFree" "true"
    '';
  };
}
