{ config, pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    
    # Latest kernel for better hardware and gaming support
    kernelPackages = pkgs.linuxPackages_latest;
    
    # Kernel parameters useful for gaming
    kernelParams = [
      "quiet"
      "splash"
    ];
  };
}
