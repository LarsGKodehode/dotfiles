{
  config,
  pkgs,
  lib,
  ...
}:

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
        pkgs.neovim
      ];

      # Set Neovim as the default editor
      home.sessionVariables = {
        EDITOR = "nvim";
      };
    };
  };
}
