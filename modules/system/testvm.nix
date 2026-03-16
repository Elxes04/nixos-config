{ config, pkgs, inputs, ... }:

{
  users.users.testvm = {
    isNormalUser = true;
    initialPassword = "test";
    extraGroups = [ "wheel" ];
  };

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 4096;
      cores = 3;
    };
  };
}