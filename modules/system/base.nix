{ config, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 3;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [ pkgs.linux-firmware ];

  # CPU microcode updates
  hardware.cpu.intel.updateMicrocode = true;

  # Enable thermal management
  services.thermald.enable = true;

  # TLP - Advanced power management for Linux
  services.tlp = {
    enable = true;
    settings = {
      # CPU settings
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 60;
      
      # Enable audio power saving
      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;
      
      # Battery settings for ThinkPad
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
      
      # Disk settings
      DISK_DEVICES = "nvme0n1";
      DISK_APM_LEVEL_ON_AC = "254 254";
      DISK_APM_LEVEL_ON_BAT = "128 128";
      
      # PCIe power management
      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";
      
      # USB autosuspend
      USB_AUTOSUSPEND = 1;
      USB_EXCLUDE_BTUSB = 1;
      USB_EXCLUDE_PHONE = 1;
    };
  };

  # Disable power-profiles-daemon (conflicts with TLP)
  services.power-profiles-daemon.enable = false;

  # Enable fstrim for SSD optimization
  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  # Enable firmware updates via fwupd
  services.fwupd.enable = true;

  # Bluetooth optimization
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false; # Don't enable BT by default to save power
    settings = {
      General = {
        ControllerMode = "dual";
        FastConnectable = true;
      };
    };
  };

  # Graphics drivers - Intel
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver  # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver  # LIBVA_DRIVER_NAME=i965 (older but sometimes better)
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime # OpenCL support
    ];
  };

  # Enable VA-API for hardware video acceleration
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD"; # Force Intel iHD driver
  };

  time.timeZone = "Europe/Rome";
  i18n.defaultLocale = "en_US.UTF-8";

  swapDevices = [ ];
  zramSwap.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Optimize Nix store automatically
  nix.optimise = {
    automatic = true;
    dates = [ "03:45" ];
  };

  environment.systemPackages = with pkgs; [
    # Essential system tools
    git
    wget
    curl
    tree
    fastfetch
    flatpak
    
    # Power management and monitoring
    powertop      # Power consumption analyzer
    acpi          # Battery status
    
    # Hardware info
    lshw          # Hardware lister
    usbutils      # lsusb
    pciutils      # lspci
    
    # Sensors and monitoring
    lm_sensors    # Hardware sensors
    
    # Disk utilities
    smartmontools # SMART monitoring for disks
    nvme-cli      # NVMe management
  ];

  security.sudo.enable = true;
  
  # Enable smartd for disk health monitoring
  services.smartd = {
    enable = true;
    autodetect = true;
  };
}
