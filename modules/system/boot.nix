{ config, pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    
    # Latest kernel for better hardware and gaming support
    kernelPackages = pkgs.linuxPackages_latest;

    initrd.availableKernelModules = [ "iwlwifi" "iwlmvm" ];
    
    # Kernel parameters useful for gaming
    kernelParams = [
      "quiet"
      "splash"
    ];
  };
}
