{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Gaming Utilities
    # gamescope           # SteamOS session compositing window manager
    mangohud            # Vulkan/OpenGL overlay for monitoring FPS, temps, etc.
    goverlay            # Graphical UI for MangoHud configuration
    
    # Game Launchers & Tools
    lutris              # Game launcher for Linux
    heroic              # Epic Games & GOG launcher
    # legendary-gl        # Epic Games Launcher (CLI)
    # bottles             # Run Windows software
    
    # Performance Monitoring
    corectrl            # AMD/Intel GPU & CPU control
    
    # Wine & Compatibility
    # wine                # Windows compatibility layer
    # winetricks          # Wine helper scripts
    
    # Emulators
    # retroarch           # Multi-system emulator frontend
    pcsx2             # PlayStation 2 emulator (uncomment if needed)
    # rpcs3             # PlayStation 3 emulator (uncomment if needed)
    # dolphin-emu       # GameCube/Wii emulator (uncomment if needed)
    
    # Discord for gaming communication
    vesktop             # Discord with Vencord & better screenshare
    
    # Controller support
    antimicrox          # Map keyboard/mouse to gamepad
  ];

  # Enable GameMode
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        amd_performance_level = "high";
      };
    };
  };
}
