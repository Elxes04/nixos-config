# NixOS Configuration (Flakes)

This repository contains a NixOS configuration using flakes for the host `nixos`. It includes system modules, KDE Plasma setup, and Home Manager integration.

## Structure
- flake.nix: Flake entry point and inputs
- hardware-configuration.nix: Auto-generated hardware config
- hosts/nixos/configuration.nix: Host-specific settings
- modules/system/*: System modules (boot, locale, networking, users, qt)
- modules/desktop/plasma.nix: KDE Plasma and SDDM setup
- modules/packages/*: Package groups (gaming, development, desktop-apps)
- home/elxes.nix: Home Manager configuration for user `elxes`
- Makefile: Convenience targets

## Requirements
- NixOS 25.11
- Flakes enabled (`nix-command` and `flakes`)

## Usage
You can use the Makefile targets or run the commands directly. Replace the host name as needed.

### With Makefile
- Rebuild and switch:
  ```sh
  make switch HOST=nixos
  ```
- Test without switching:
  ```sh
  make test HOST=nixos
  ```
- Set next boot:
  ```sh
  make boot HOST=nixos
  ```
- Update inputs and check:
  ```sh
  make update
  make check
  ```
- List system generations:
  ```sh
  make list-generations
  ```

### Direct Commands
- Rebuild and switch:
  ```sh
  sudo nixos-rebuild switch --flake .#nixos
  ```
- Update inputs:
  ```sh
  nix flake update
  ```

## Notes
- `system.stateVersion` should reflect the version originally installed to avoid unintended migrations.
- KDE Plasma is configured via modules/desktop/plasma.nix. SDDM Wayland can be toggled in the same file if needed.

## Troubleshooting
- If a rebuild fails, run with `--show-trace` for detailed errors.
- Ensure your user matches Home Manager configuration (currently `elxes`). Update `home/elxes.nix` or flake.nix if using a different username.
- Ensure the host name (`nixos`) matches the flake output key under `nixosConfigurations`. If your flake uses a different name, change the examples accordingly.
