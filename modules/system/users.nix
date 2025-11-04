{ config, ... }: {
  users.users.elxes = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
