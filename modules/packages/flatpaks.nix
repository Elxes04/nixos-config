{ config, pkgs, ... }:

{
  services.flatpak.enable = true;

  services.flatpak.remotes = [
    {
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }
  ];

  services.flatpak.packages = [
    "app.zen_browser.zen"
    "com.github.gabutakut.gabutdm"
    "com.github.tchx84.Flatseal"
    "com.stremio.Stremio"
    "com.termius.Termius"
    "io.github.victoralvesf.aonsoku"
    "org.keepassxc.KeePassXC"
    "org.shotcut.Shotcut"
    "org.vinegarhq.Sober"
  ];
}
