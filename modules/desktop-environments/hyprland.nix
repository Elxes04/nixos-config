{ config, pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Essential packages for Hyprland
  environment.systemPackages = with pkgs; [
    # Wayland tools
    wayland
    wayland-protocols
    wayland-utils
    wl-clipboard
    wlr-randr
    
    # Screenshot & screen recording
    grim                # Screenshot tool
    slurp               # Region selector
    wf-recorder         # Screen recorder
    
    # Notification daemon
    dunst               # Or mako
    libnotify           # For notify-send
    swayosd             # OSD for volume/brightness
    
    # App launcher
    rofi                # Application launcher (supports Wayland)
    
    # Bar (optional - Hyprland has built-in bar support via waybar)
    waybar              # Status bar
    
    # Terminal (if not already installed)
    kitty               # GPU-accelerated terminal
    
    # Network management
    networkmanagerapplet
    
    # Audio control
    pavucontrol         # PulseAudio/PipeWire volume control
    
    # Brightness control
    brightnessctl       # For laptop brightness
    
    # Screen locker
    swaylock-effects    # Screen lock
    
    # Idle daemon
    swayidle            # Idle management
    
    # Clipboard manager
    cliphist            # Clipboard history
    
    # Wallpaper
    hyprpaper           # Wallpaper daemon for Hyprland
    # or swww          # Alternative wallpaper daemon
    
    # Color picker
    hyprpicker          # Color picker for Hyprland
    
    # Authentication agent
    kdePackages.polkit-kde-agent-1  # Polkit authentication (KDE 6)
    
    # Qt theming
    qt5.qtwayland
    qt6.qtwayland
    libsForQt5.qt5ct
    
    # GTK theming
    gsettings-desktop-schemas
    
    # Portals for screen sharing
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
  ];

  # XDG Portal configuration
  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # Enable required services
  services.gnome.gnome-keyring.enable = true;
  
  # Environment variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";  # Hint Electron apps to use Wayland
    WLR_NO_HARDWARE_CURSORS = "1";  # Fix for some cursor issues
    MOZ_ENABLE_WAYLAND = "1";  # Firefox Wayland
  };
}
