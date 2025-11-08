{ config, lib, pkgs, ... }:

{
  # Enable hardware support for Realtek WiFi cards
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;

  # Realtek WiFi firmware
  hardware.firmware = with pkgs; [
    linux-firmware
  ];

  # Kernel modules for Realtek WiFi (rtw88, rtw89 series)
  boot.kernelModules = [ "rtw88_pci" "rtw89_pci" ];
  
  # Kernel parameters for Realtek WiFi
  boot.kernelParams = [
    # Disable ASPM which can cause issues
    "pcie_aspm=off"
  ];

  # Extra module parameters for Realtek WiFi
  boot.extraModprobeConfig = ''
    # Realtek WiFi options
    options rtw88_pci disable_aspm=1
    options rtw89_pci disable_aspm=1
  '';

  # Ensure NetworkManager is properly configured
  networking.networkmanager.wifi.powersave = false;
  
  # Use wpa_supplicant backend
  networking.networkmanager.wifi.backend = "wpa_supplicant";
  
  # Enable wireless but let NetworkManager handle it
  networking.wireless.enable = lib.mkForce false;
}
