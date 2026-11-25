{ config, pkgs, inputs, ... }:

{
  imports = [
    # DankMaterialShell
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri

    ./programs/dms/dms.nix
    ./programs/niri/niri.nix

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
    ./programs/dev/java.nix
  ];

  # Home Manager state version
  home.stateVersion = "26.05";

  # DankMaterialShell
  programs.dank-material-shell = {
    enable = true;

    niri = {
      enableKeybinds = false;
      enableSpawn = true;
    };
  };

  home.packages = with pkgs; [
    unstable.vscode
    unstable.lazygit
    unstable.dbeaver-bin
    unstable.lazydocker
    unstable.dive
    unstable.postman
    unstable.ripgrep
    unstable.fd
    unstable.tldr
    httpie
    fastfetch
    adwaita-icon-theme
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    dejavu_fonts
    liberation_ttf
  ];
}