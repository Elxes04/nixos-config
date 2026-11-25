{ ... }:

{
  programs.niri = {
    settings = {
      input = {
        keyboard = {
          xkb = {
            layout = "it";
            variant = "";
            options = "";
          };
        };
      };

      hotkey-overlay.skip-at-startup = true;

      layout.background-color = "transparent";

      layer-rules = [
        {
          matches = [ { namespace = "^wallpaper$"; } ];
          place-within-backdrop = true;
        }
      ];
    };
  };
}