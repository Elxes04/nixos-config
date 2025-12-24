{ config, pkgs, ... }:

{
  users.users.elxes = {
    isNormalUser = true;
    description = "Elxes";
    extraGroups = [ 
      "wheel" 
      "networkmanager" 
      "video" 
      "audio"
      "docker"
      "libvirtd"
    ];
    
    # Default shell
    shell = pkgs.zsh;
  };

  # Enable zsh
  programs.zsh.enable = true;
}
