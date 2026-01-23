{ config, pkgs, ... }:

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
    ];

    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "FiraCode Nerd Font" ];
    };
  };

  # Custom fonts from local directory
  system.userActivationScripts.installCustomFonts = {
    text = ''
      mkdir -p ~/.local/share/fonts
      cp -v ${../../fonts}/*.ttf ~/.local/share/fonts/ 2>/dev/null || true
      fc-cache -f ~/.local/share/fonts 2>/dev/null || true
    '';
  };
}
