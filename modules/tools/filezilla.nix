{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    filezilla
  ];
}
