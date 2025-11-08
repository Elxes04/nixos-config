{ config, lib, pkgs, ... }:

{
  # Enable hardware support for MediaTek WiFi cards
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;

  # MediaTek WiFi firmware
  hardware.firmware = with pkgs; [
    linux-firmware
  ];

  # Kernel modules for MediaTek WiFi (mt7921e, mt7922, mt76 series)
  boot.kernelModules = [ "mt7921e" "mt76" ];
  
  # Kernel parameters for MediaTek WiFi
  boot.kernelParams = [
    # Disable ASPM which can cause issues with some cards
    "pcie_aspm=off"
  ];

  # Extra module parameters for MediaTek WiFi
  boot.extraModprobeConfig = ''
    # MediaTek WiFi options
    options mt7921e disable_aspm=1
  '';

  # Ensure NetworkManager is properly configured
  networking.networkmanager.wifi.powersave = false;
  
  # Use wpa_supplicant backend
  networking.networkmanager.wifi.backend = "wpa_supplicant";
  
  # Enable wireless but let NetworkManager handle it
  networking.wireless.enable = lib.mkForce false;
}
