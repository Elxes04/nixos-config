
{ config, pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;
    enableIPv6 = false;

    extraHosts = ''
      127.0.0.1 public-ubiservices.ubi.com
    '';

    firewall = {
      enable = true;

      allowedTCPPorts = [
        22
        80
        443
        2222
        26753
        18363
        53317
        3552
      ];

      allowedUDPPorts = [];
    };
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;

    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  services.openssh = {
    enable = true;

    settings = {
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  # FRP Client Configuration for Minecraft
  services.frp = {
    instances."" = {
      enable = true;
      role = "client";

      settings = {
        serverAddr = "92.4.161.202";
        serverPort = 10000;

        auth = {
          method = "token";
          token = "aYM4NF&NJ0@$%jsMKe@7!0QzyFtRva7AXsk!JUK8veR8H%&xPBw@8$$rHgFrGXuW";
        };

        proxies = [
          {
            name = "minecraft-java";
            type = "tcp";
            localIP = "127.0.0.1";
            localPort = 26753;
            remotePort = 26753;
          }

          {
            name = "minecraft-pvp";
            type = "tcp";
            localIP = "127.0.0.1";
            localPort = 25565;
            remotePort = 25565;
          }
        ];
      };
    };
  };
}
