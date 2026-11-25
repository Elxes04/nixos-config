
{ pkgs, ... }:

{
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  services.system76-scheduler.enable = true;

  # Workaround for the incorrect cosmic-edit source hash
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit
  ];
}
