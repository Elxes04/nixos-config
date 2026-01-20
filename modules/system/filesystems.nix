{ config, pkgs, ... }:

{
  # Filesystem support
  environment.systemPackages = with pkgs; [
    # NTFS support
    ntfs3g
    ntfsprogs
    
    # exFAT support
    exfat
    exfatprogs
    
    # ISO support
    cdrtools
    
    # Filesystem utilities
    e2fsprogs
    btrfs-progs
    xfsprogs
    dosfstools
    gptfdisk
  ];

  # Enable GVFS for better file manager integration with remote filesystems
  services.gvfs = {
    enable = true;
    package = pkgs.gvfs;
  };
}
