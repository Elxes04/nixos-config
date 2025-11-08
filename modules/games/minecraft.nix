{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Prism Launcher - Modern, feature-rich Minecraft launcher
    # Supports mods, modpacks, multiple instances, and all Java versions
    # Can also extract and use OptiFine
    prismlauncher
    
    # Note: Official Minecraft launcher is currently broken in NixOS
    # Prism Launcher is a complete replacement with more features
    # For OptiFine: download the .jar and add it as a mod in Prism Launcher
  ];

  # Prism Launcher works best with all Java versions available
  # Java configuration is in modules/development/java.nix
}
