{ config, pkgs, lib, ... }:

{
  # Hostname
  networking.hostName = "nixos";

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
  };


  # Enable flakes and nix command
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  hardware.enableRedistributableFirmware = true;

  # Ensure Intel iGPU kernel module is available early
  boot.kernelModules = [ "kvm-intel" "i915" ];

  # Enable OpenGL / DRI support and prefer Intel driver (modesetting is used by default)
  hardware.graphics = {
    enable = true;
  };

  # For X11/Wayland desktop drivers — include intel driver (modesetting is preferred for modern setups)
  services.xserver = {
    enable = true;
    videoDrivers = [ "intel" ];
  };

  # System version
  system.stateVersion = "25.05";
}
