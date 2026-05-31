{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Elxes04";
        email = "124086168+Elxes04@users.noreply.github.com";
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
}
