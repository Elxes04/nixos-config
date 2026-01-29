{
  description = "NixOS Configuration with Flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    darkly = {
      url = "github:Bali10050/Darkly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, darkly, ... }@inputs:
    let
      system = "x86_64-linux";
      
      # Overlay for unstable packages
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
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
            ./modules/system/boot.nix
            ./modules/system/locale.nix
            ./modules/system/networking.nix
            ./modules/system/users.nix
            ./modules/system/qt.nix
            ./modules/system/filesystems.nix
            ./modules/system/fonts.nix
            ./modules/desktop/cosmic.nix
            ./modules/desktop/examine.nix
            ./modules/games/minecraft.nix
            ./modules/packages/gaming.nix
            ./modules/packages/development.nix
            ./modules/packages/desktop-apps.nix
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
    };
}
