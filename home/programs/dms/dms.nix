{ ... }:

{
  programs.dank-material-shell = {
    enable = true;

    niri = {
      enableKeybinds = false;

      includes = {
        enable = true;
        override = true;

        originalFileName = "hm";

        filesToInclude = [
          "alttab"
          "binds-next"
          "binds"
          "colors"
          "cursor"
          "layout"
          "outputs"
          "windowrules"
          "wpblur"
        ];
      };
    };
  };
}