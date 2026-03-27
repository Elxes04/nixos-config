{ config, pkgs, ... }:

{
  services.flatpak.enable = true;

  services.flatpak.remotes = [
    {
      name = "flathub";
      location = "https://flathub.org/repo/flathub.flatpakrepo";
    }
  ];

  services.flatpak.packages = [
    "app.zen_browser.zen"
    "com.github.gabutakut.gabutdm"
    "com.github.tchx84.Flatseal"
    "com.mattjakeman.ExtensionManager"
    "com.termius.Termius"
    "org.keepassxc.KeePassXC"
    "org.localsend.localsend_app"
    "org.shotcut.Shotcut"
    "org.vinegarhq.Sober"
  ];
}