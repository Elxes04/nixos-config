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
        53317
      ];

      allowedUDPPorts = [ ];
    };
  };

  boot.kernel.sysctl = {
    "net.ipv4.ip_unprivileged_port_start" = 443;
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
