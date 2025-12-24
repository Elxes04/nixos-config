{ config, pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;
    
    # Firewall configuration
    firewall = {
      # Disable the built-in NixOS firewall while testing
      enable = false;
      allowedTCPPorts = [ 22 18363 ];
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
}
