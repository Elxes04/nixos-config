{ config, pkgs, ... }:

let
  meslo-lgs-fonts = pkgs.runCommand "meslo-lgs-fonts" { } ''
    mkdir -p $out/share/fonts/truetype
    cp -v ${../../fonts}/*.ttf $out/share/fonts/truetype/
  '';
in
{
  fonts = {
    packages = with pkgs; [
      # System fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      font-awesome
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.hack

      # Custom fonts from local directory
      meslo-lgs-fonts
    ];

    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "FiraCode Nerd Font" ];
    };
  };
}
