{
  config,
  pkgs,
  lib,
  ...
}:

let
  neovim = import ./package {
    inherit pkgs;
    colors = config.theme.colors;
  };
in
  {
    options = {
      neovim.enable = lib.mkEnableOption {
        description = "Enable Neovim";
        type = lib.types.bool;
        default = false;
      };
    };

    config = lib.mkIf (config.neovim.enable) {
      home-manager.users.${config.user} = {
        home.packages = [
          neovim
        ];

        # Set Neovim as the default editor
        home.sessionVariables = {
          EDITOR = "nvim";
        };

        # Aliases for launching Neovim
        programs.fish = {
          shellAliases = {
            vim = "nvim";
          };

          shellAbbrs = {
            v = "nvim";
          };
        };
      };
    };
  }
