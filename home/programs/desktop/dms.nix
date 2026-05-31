{ config, pkgs, ... }:

{
  xdg.configFile."niri/dms/windowrules.kdl" = {
    text = builtins.readFile ./dms/windowrules.kdl;
    force = true;
  };

  xdg.configFile."niri/dms/binds.kdl" = {
    text = builtins.readFile ./dms/binds.kdl;
    force = true;
  };

  xdg.configFile."niri/dms/cursor.kdl" = {
    text = builtins.readFile ./dms/cursor.kdl;
    force = true;
  };

  xdg.configFile."niri/dms/outputs.kdl" = {
    text = builtins.readFile ./dms/outputs.kdl;
    force = true;
  };
}
