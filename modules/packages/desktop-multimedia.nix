{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    unstable.mpv
    obs-studio
    unstable.gimp
    easyeffects
    gapless
    gelly
    upscayl
    unstable.gpu-screen-recorder
    unstable.wf-recorder
  ];
}
