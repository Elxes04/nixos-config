{ config, pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;
    
    # Firewall configuration
    firewall = {
      enable = false;
      allowedTCPPorts = [ 22 2222 18363 ];
      allowedUDPPorts = [ ];
    };
  };


  # Enable avahi for network discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  # Enable OpenSSH server
  services.openssh.enable = true;
  services.openssh.settings = {
    PermitRootLogin = "yes";
    PasswordAuthentication = true;
    KbdInteractiveAuthentication = false;
  };
}
