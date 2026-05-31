{
  description = "NixOS Configuration with Flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nix-flatpak, ... }@inputs:
    let
      system = "x86_64-linux";

      # Overlay for unstable packages
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
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
        ];
        desktop = [
          ./modules/desktop/niri.nix
          ./modules/desktop/dms.nix
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

          specialArgs = { inherit inputs; };

          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })

            ./hardware-configuration.nix
            ./hosts/nixos/configuration.nix
          ] ++ moduleGroups.system ++ moduleGroups.desktop ++ moduleGroups.games ++ moduleGroups.packages ++ [
            nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-bak";
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.elxes = import ./home/elxes.nix;
            }
          ];
        };
      };

      nixosModules = moduleGroups;
    };
}