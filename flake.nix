{
  description = "WSL NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nixos-wsl, home-manager }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # TODO Move to moreaptly named modules
          ./configuration.nix

          # WSL Configurations
          nixos-wsl.nixosModules.default
          {
            system.stateVersion = "24.05"; # Don't touch!

            wsl = {
              enable = true;
              defaultUser = "zab";
            };
          }

          # Home Manager Configurations
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.zab = import ./home.nix;
            # Arguments to pass in to the home.nix function
            home-manager.extraSpecialArgs = {
              username = "zab";
            };
          }
        ];
      };
    };
  };
}
