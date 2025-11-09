{ config, pkgs, ... }:

{
  # Enable support for various filesystems
  boot.supportedFilesystems = [
    "ntfs"      # Windows NTFS
    "exfat"     # exFAT (USB drives, SD cards)
    "f2fs"      # Flash-Friendly File System
    "btrfs"     # B-tree filesystem
    "xfs"       # XFS filesystem
    # "zfs"     # ZFS filesystem (requires compatible kernel, see note below)
  ];

  # Install filesystem tools
  environment.systemPackages = with pkgs; [
    # NTFS support (read/write for Windows drives)
    ntfs3g
    
    # exFAT support (USB drives, SD cards)
    exfat
    exfatprogs
    
    # FAT/FAT32 utilities
    dosfstools
    mtools
    
    # ext2/ext3/ext4 utilities
    e2fsprogs
    
    # Btrfs utilities
    btrfs-progs
    
    # XFS utilities
    xfsprogs
    
    # F2FS utilities
    f2fs-tools
    
    # General disk utilities
    gptfdisk      # GPT partition editor
    parted        # Partition editor
    gparted       # GUI partition editor
    
    # Filesystem checking and repair
    testdisk      # Data recovery tool
    
    # ISO and image tools
    cdrtools      # CD/DVD tools
    dvdplusrwtools
  ];

  # Enable NTFS-3G for automatic NTFS mounting with read/write
  boot.kernelModules = [ "ntfs3" ];  # Modern in-kernel NTFS driver

  # Auto-mount removable media (USB drives, etc.)
  services.udisks2.enable = true;
  
  # Enable GVFS for better file manager integration
  services.gvfs.enable = true;

  # Note about ZFS:
  # ZFS requires additional configuration and kernel module compilation
  # If you need ZFS, uncomment these lines:
  # boot.supportedFilesystems = [ "zfs" ];
  # networking.hostId = "12345678";  # Required for ZFS (generate random 8 hex digits)
  # boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
}
