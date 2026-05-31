{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = pkgs.writeTextDir "share/zsh/plugins/powerlevel10k-config/powerlevel10k-config.zsh" ''
          # Powerlevel10k configuration
          if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
            source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
          fi
          
          [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
        '';
        file = "share/zsh/plugins/powerlevel10k-config/powerlevel10k-config.zsh";
      }
    ];

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
      ncg = "sudo nix-collect-garbage -d";

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
}
