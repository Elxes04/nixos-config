{ config, pkgs, inputs, ... }:

{
  # Home Manager state version
  home.stateVersion = "25.05";


  home.packages = with pkgs; [
    unstable.vscode
    unstable.lazygit
    unstable.dbeaver-bin
    unstable.pgadmin4-desktopmode
    unstable.lazydocker
    unstable.dive
    unstable.postman
    unstable.insomnia
    unstable.ripgrep
    unstable.fd
    unstable.tldr
    httpie
    fastfetch
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "elxes";
        email = "your.email@example.com";
      };
      init = { defaultBranch = "main"; };
      pull = { rebase = false; };
      credential = { helper = "store"; };
      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        unstage = "reset HEAD --";
        last = "log -1 HEAD";
        graph = "log --graph --oneline --decorate --all";
      };
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      command_timeout = 1000;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "docker" "kubectl" "npm" "python" "rust" ];
      theme = "robbyrussell";
    };

    shellAliases = {
      ll = "eza -la";
      ls = "eza";
      cat = "bat";
      vim = "nvim";

      # Nix shortcuts
      nrs = "sudo nixos-rebuild switch --flake .#nixos";
      nrt = "sudo nixos-rebuild test --flake .#nixos";
      nrb = "sudo nixos-rebuild boot --flake .#nixos";
      nfu = "nix flake update";
      nfc = "nix flake check";
      ncg = "nix-collect-garbage -d";

      # Git shortcuts
      g = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";

      # Docker shortcuts
      d = "docker";
      dc = "docker-compose";
      dps = "docker ps";
      dpa = "docker ps -a";
    };

    initContent = ''
      # Custom functions
      function mkcd() {
        mkdir -p "$1" && cd "$1"
      }

      # Better cd with z
      eval "$(zoxide init zsh)"
    '';
  };

  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
    };
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    icons = "auto";
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f";
    defaultOptions = [
      "--height 40%"
      "--border"
    ];
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    terminal = "screen-256color";
    extraConfig = ''
      # Split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf
    '';
  };

  programs.htop = {
    enable = true;
    settings = {
      tree_view = true;
      show_program_path = false;
    };
  };

  # Remove HM Qt overrides to avoid conflicts with KDE session
}
