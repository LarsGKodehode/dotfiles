{
  # This configuration setup is heavily inspired by nmasur
  # https://github.com/nmasur/dotfiles
  description = "My System";

  inputs = {

    # System Packages
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    # Used for Windows Subsystem for Linux compability
    wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Used for user packages and dotfiles
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs"; # Use system package list for their inputs
    };
  };

  outputs = 
    { nixpkgs, ... }@inputs:
    
    let    
      # Global Configuration for my systems
      globals =
        rec {
          user = "zab";
          fullName = "zabronax";
          gitName = fullName;
          gitEmail = "104063134+LarsGKodehode@users.noreply.github.com";
        };

      # Put always enabled overlays in this list
      overlays = [];

      # System types to support
      supportedSystems = [
        "x86_64-linux"
      ];

      # Helper function to generate an attribute set '{ x86_64-linux = f "x86_64-linux"; ... }'
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    in
    rec {
      # Contains full system builds including home manager
      # nixos-rebuild switch --flake .#weasel
      nixosConfigurations = {
        weasel = import ./hosts/weasel { inherit inputs globals overlays; };
      };
    };
}
