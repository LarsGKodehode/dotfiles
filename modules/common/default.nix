{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./shell
    ./applications
  ];

  options = {
    user = lib.mkOption {
      type = lib.types.str;
      description = "Primary user of the system.";
    };

    fullName = lib.mkOption {
      type = lib.types.str;
      description = "Human readable name of the user.";
    };

    unfreePackages = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "List of unfree packages to allow.";
      default = [ ];
    };

    homePath = lib.mkOption {
      type = lib.types.path;
      description = "Path of user's home directory.";
      default = builtins.toPath("/home/${config.user}");
    };

    dotfilesPath = lib.mkOption {
      type = lib.types.path;
      description = "Path of dotfiles repository.";
      default = builtins.toPath(config.homePath + "/.nixos-configuration");
    };

    theme = {
      colors = lib.mkOption {
        type = lib.types.attrs;
        description = "Base16 color scheme.";
        default = (import ../colorscheme/nord).dark;
      };
      dark = lib.mkOption {
        type = lib.types.bool;
        description = "Enable dark mode.";
        default = true;
      };
    };
  };

  config =
    let
      stateVersion = "24.05";
    in
    {
      # Basic common packages for all devices
      environment.systemPackages = with pkgs; [
        git
        curl
        wget
      ];

      # Use system-level packages instead of Home Manager's
      home-manager.useGlobalPkgs = true;

      # Install packages to /etc/profiles instead of ~/.nix-profile, useful when
      # using multiple profiles for one user
      home-manager.useUserPackages = true;

      # Allow specified unfree packages (identified elsewhere)
      # Retrieves package object based on string name
      nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) config.unfreePackages;

      # Pin a state version to prevent warnings
      home-manager.users.${config.user}.home.stateVersion = stateVersion;
      home-manager.users.root.home.stateVersion = stateVersion;
    };
}
