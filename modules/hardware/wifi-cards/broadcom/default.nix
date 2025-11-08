{ config, lib, pkgs, ... }:

{
  # Enable hardware support for Broadcom WiFi cards
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;

  # Broadcom WiFi firmware
  hardware.firmware = with pkgs; [
    linux-firmware
  ];

  # Kernel modules for Broadcom WiFi
  boot.kernelModules = [ "wl" ];
  
  # Broadcom WiFi driver (proprietary)
  boot.extraModulePackages = with config.boot.kernelPackages; [
    broadcom_sta
  ];

  # Blacklist conflicting open-source drivers
  boot.blacklistedKernelModules = [ "b43" "bcma" "ssb" ];

  # Extra module parameters for Broadcom WiFi
  boot.extraModprobeConfig = ''
    # Disable conflicting modules
    blacklist b43
    blacklist bcma
    blacklist ssb
  '';

  # Ensure NetworkManager is properly configured
  networking.networkmanager.wifi.powersave = false;
  
  # Use wpa_supplicant backend
  networking.networkmanager.wifi.backend = "wpa_supplicant";
  
  # Enable wireless but let NetworkManager handle it
  networking.wireless.enable = lib.mkForce false;
}
