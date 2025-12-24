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
        thinkpad-x380 = nixpkgs.lib.nixosSystem {
          inherit system;
          
          specialArgs = { inherit inputs; };
          
          modules = [
            # Overlay for unstable
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
            
            # Hardware configuration
            ./hardware-configuration.nix
            
            # Host configuration
            ./hosts/thinkpad-x380/configuration.nix
            
            # System modules
            ./modules/system/boot.nix
            ./modules/system/locale.nix
            ./modules/system/networking.nix
            ./modules/system/users.nix
            ./modules/system/qt.nix
            # (Stylix removed)
            
            # Desktop environment
            ./modules/desktop/plasma.nix
            
            # Games
            ./modules/games/minecraft.nix
            
            # Packages by category
            ./modules/packages/gaming.nix
            ./modules/packages/development.nix
            ./modules/packages/desktop-apps.nix
            
            # Home Manager
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
