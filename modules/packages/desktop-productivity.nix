{ pkgs, ... }:
with pkgs; [
  libreoffice-fresh
  hunspell
  hunspellDicts.it_IT
  hunspellDicts.en_US
  keepassxc
]
