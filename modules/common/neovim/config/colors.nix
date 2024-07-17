{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Set Neovim colors based on Nix colorscheme
  options.colors = lib.mkOption {
    description = "Attribute Set of base16 colorscheme key value pairs.";
    type = lib.types.attrsOf lib.types.str;
  };

  config = {
    plugins = [ pkgs.vimPlugins.base16-nvim ];
    setup.base16-colorscheme = config.colors;
  };
}

