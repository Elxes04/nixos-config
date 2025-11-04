{ config, pkgs, lib, ... }:

{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7299edac-4c9a-4bf6-a9a4-eb3e794c4689";
    fsType = "btrfs";
    options = [ "noatime" "ssd" "space_cache=v2" "compress=zstd:10" "subvol=@" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/74a667c9-068c-43ab-b58c-ec36bdd5d5eb";
    fsType = "btrfs";
    options = [ "noatime" "ssd" "space_cache=v2" "compress=zstd:10" "subvol=@home" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/303A-A140";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  swapDevices = [ ];
}
