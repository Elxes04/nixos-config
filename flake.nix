
{
  description = "NixOS Configuration with Flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Niri
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # DankMaterialShell (DMS)
    dms = {
      url = "github:duxlabs-dev/dux-shell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flatpak
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
    };

    # PrismLauncher
    prismlauncher = {
      url = "github:Diegiwg/PrismLauncher-Cracked";
    };

    # Google Antigravity
    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nix-flatpak,
    niri,
    dms,
    ...
  }@inputs:
    let
      system = "x86_64-linux";

      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      overlay-unstable = final: prev: {
        unstable = pkgs-unstable;
      };

      moduleGroups = {
        system = [
          ./modules/system/host.nix
          ./modules/system/nix.nix
          ./modules/system/graphics.nix
          ./modules/system/audio.nix
          ./modules/system/state-version.nix
          ./modules/system/boot.nix
          ./modules/system/locale.nix
          ./modules/system/networking.nix
          ./modules/system/users.nix
          ./modules/system/filesystems.nix
          ./modules/system/testvm.nix
          ./modules/system/fonts.nix
          ./modules/system/xray-server.nix
        ];

        games = [
          ./modules/games/minecraft.nix
        ];

        packages = [
          ./modules/packages/gaming.nix
          ./modules/packages/development.nix
          ./modules/packages/flatpaks.nix
          ./modules/packages/desktop-apps.nix
        ];
      };
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit inputs pkgs-unstable;
          };

          modules = [
            # Custom overlays and system packages
            ({ pkgs, ... }: {
              nixpkgs.overlays = [
                overlay-unstable
              ];

              # Niri
              programs.niri = {
                enable = true;
                package = pkgs.niri;
              };

              environment.systemPackages = [
                inputs.prismlauncher.packages.${pkgs.system}.prismlauncher

                # Google Antigravity
                inputs.antigravity-nix.packages.${pkgs.system}.default
                inputs.antigravity-nix.packages.x86_64-linux.default
                inputs.antigravity-nix.packages.x86_64-linux.google-antigravity-ide
                inputs.antigravity-nix.packages.x86_64-linux.google-antigravity-cli
              ];
            })

            # Niri NixOS module
            niri.nixosModules.niri

            # Hardware and host configuration
            ./hardware-configuration.nix
            ./hosts/nixos/configuration.nix
          ]

          ++ moduleGroups.system
          ++ moduleGroups.games
          ++ moduleGroups.packages

          ++ [
            # Flatpak
            nix-flatpak.nixosModules.nix-flatpak

            # Home Manager
            home-manager.nixosModules.home-manager

            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-bak";

              home-manager.extraSpecialArgs = {
                inherit inputs;
              };

              home-manager.users.elxes = import ./home/elxes.nix;
            }
          ];
        };
      };

      # Exported module groups
      nixosModules = moduleGroups;
    };
}
