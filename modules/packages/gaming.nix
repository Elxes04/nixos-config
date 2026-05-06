{ config, pkgs, ... }:

{
  # Gaming programs and services
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
    };
    
    gamemode.enable = true;
  };


  services.udev.packages = with pkgs; [
    game-devices-udev-rules
  ];
  
  # Hardware acceleration and drivers (configured in main configuration.nix)

  # Gaming packages (many from unstable for latest versions)
  environment.systemPackages = with pkgs; [
    # Launchers and platforms
    unstable.heroic
    
    # Emulators
    unstable.pcsx2
    
    # Tools
    unstable.mangohud
    unstable.goverlay
    protonup-qt
    cabextract
    
    # Vulkan
    vulkan-tools
    vulkan-loader
    
    # Vulkan 32-bit support for games
    pkgsi686Linux.vulkan-loader
    
    # Performance monitoring
    unstable.cpu-x
    btop
  ];

  # Gaming optimizations
  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642; # For some games
  };
}
