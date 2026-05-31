{ config, pkgs, inputs, ... }:

{
  imports = [
    # Shell programs
    ./programs/shell/zsh.nix
    ./programs/shell/starship.nix
    ./programs/shell/zoxide.nix
    
    # Development tools
    ./programs/dev/git.nix
    ./programs/dev/neovim.nix
    ./programs/dev/nix-index.nix
    
    # CLI utilities
    ./programs/cli/bat.nix
    ./programs/cli/eza.nix
    ./programs/cli/fzf.nix
    ./programs/cli/direnv.nix
    ./programs/cli/tmux.nix
    
    # Desktop environment
    ./programs/desktop/niri.nix
    ./programs/desktop/dms.nix
  ];

  # Home Manager state version
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    unstable.vscode
    unstable.lazygit
    unstable.dbeaver-bin
    unstable.pgadmin4-desktopmode
    unstable.lazydocker
    unstable.dive
    unstable.postman
    unstable.ripgrep
    unstable.fd
    unstable.tldr
    httpie
    fastfetch
  ];
}
