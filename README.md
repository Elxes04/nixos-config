# NixOS config

This is my NixOS flake for a desktop setup with Niri, Home Manager, and a few custom bits for development and day-to-day use.

The repo is organized around a few main pieces:

- [flake.nix](flake.nix): flake entry point and the host definitions
- [hosts/nixos/configuration.nix](hosts/nixos/configuration.nix): machine-specific settings
- [modules/](modules/): reusable system modules
- [home/](home/): Home Manager configuration

## Quick start

If you are setting this up on a new machine, the usual flow is:

```bash
sudo nixos-rebuild switch --flake .#nixos
```

For a dry run before switching:

```bash
sudo nixos-rebuild test --flake .#nixos
```

## Useful commands

These are available through zsh aliases as well:

```bash
nrs   # rebuild and switch the main host
nrt   # rebuild and test the main host
nrb   # rebuild and set the new config for next boot
nfu   # update flake inputs
nfc   # run flake checks
nfi   # build the live ISO
```

To build the live ISO manually:

```bash
nix build .#packages.x86_64-linux.iso
```

## Live ISO

There is also a graphical live CD target in this flake. It is useful for booting into a desktop environment, installing NixOS, or testing the configuration without touching the installed system.

## Notes

- The default user is `elxes` for the main host.
- The default hostname is `nixos`.
- The live CD user is `nixos` with password `nixos`.
- If you change hardware, review [hardware-configuration.nix](hardware-configuration.nix) after a fresh install.

## A few things included

- Niri as the window manager
- Home Manager setup for shell tools, editors, and common CLI utilities
- Development tools such as Git, Neovim, VS Code, Docker tooling, and language toolchains
- Desktop apps for browsing, communication, office work, media, and virtualization
