{
  description = "💻 Elxes NixOS Configuration — Modular system and user setup using flakes";

  inputs = {
    # Main Nix package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Home Manager (for user-level config)
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true; # for Steam, VSCode, etc.
    };
  in {
    # NixOS System Configuration
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; }; # pass flake inputs to modules

      modules = [
        ./hosts/nixos.nix

        # Enable Home Manager integration
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.elxes = import ./home.nix;
        }
      ];
    };

    # Dev shell for editing and maintaining this repo
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [ git nixfmt ];
      shellHook = ''
        echo "Welcome to NixOS development shell 💜"
      '';
    };

  };
}
