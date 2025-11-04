{ config, pkgs, ... }:

{
  # Docker - Container platform
  virtualisation.docker.enable = true;
  
  # Add user to docker group
  users.users.elxes.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}