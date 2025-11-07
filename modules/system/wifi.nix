{ config, lib, pkgs, ... }:

{
  # Enable hardware support for Intel WiFi cards
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;

  # Explicitly enable Intel WiFi firmware
  hardware.firmware = with pkgs; [
    linux-firmware
  ];

  # Kernel modules for Intel WiFi
  boot.kernelModules = [ "iwlwifi" ];
  
  # Kernel parameters to help with iwlwifi stability and timeout issues
  boot.kernelParams = [
    # Disable power saving for iwlwifi (can cause issues)
    "iwlwifi.power_save=0"
    # Enable 11n on iwlwifi
    "iwlwifi.11n_disable=0"
    # Disable ASPM (Active State Power Management) that can cause issues
    "pcie_aspm=off"
    # Enable PCI quirks to fix bus mastering issues
    "pci=assign-busses,hpbussize=0x33,realloc"
  ];

  # Extra module parameters for iwlwifi
  boot.extraModprobeConfig = ''
    # Intel WiFi options
    options iwlwifi power_save=0
    options iwlwifi 11n_disable=0
    options iwlwifi bt_coex_active=0
    options iwlwifi uapsd_disable=1
    options iwlwifi swcrypto=1
  '';

  # UDev rule to enable PCI Bus Mastering very early
  services.udev.extraRules = ''
    # Enable Bus Mastering for Intel WiFi 8265 before driver loads
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x8086", ATTR{device}=="0x24fd", RUN+="${pkgs.pciutils}/bin/setpci -s $kernel COMMAND=0x0006"
  '';

  # Ensure NetworkManager is properly configured
  networking.networkmanager.wifi.powersave = false;
  
  # Use standard wpa_supplicant backend (more stable than iwd)
  networking.networkmanager.wifi.backend = "wpa_supplicant";
  
  # Enable wireless but let NetworkManager handle it
  networking.wireless.enable = lib.mkForce false;
}
