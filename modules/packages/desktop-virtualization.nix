{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    wl-clipboard
    podman-desktop
    podman
  ];
}