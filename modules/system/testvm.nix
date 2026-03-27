{ config, pkgs, inputs, ... }:

{
  users.users.testvm = {
    isNormalUser = true;
    initialPassword = "test";
    extraGroups = [ "wheel" ];
  };

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 2048;
      cores = 1;
    };
  };
}
