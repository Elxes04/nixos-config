{ config, pkgs, ... }:

{
  home.username = "elxes";
  home.homeDirectory = "/home/elxes";
  home.stateVersion = "25.05";

  # User-level packages (avoid duplicating system packages)
  home.packages = with pkgs; [
    # User-specific configs and dotfiles tools
    stow            # Dotfiles management
    chezmoi         # Alternative dotfiles manager
  ];

  # Program configurations
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Elxes";
        email = "elxes@example.com";
      };
    };
  };

  programs.zsh.enable = true;

  # Optional user-space services
  services.gpg-agent.enable = true;
}
