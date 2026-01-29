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
        2222
        18363
      ];

      allowedUDPPorts = [ ];
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
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
    };
  };
}
