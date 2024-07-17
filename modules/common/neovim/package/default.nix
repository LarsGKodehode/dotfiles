{
  pkgs,
  colors,
  ...
}:

# Comes from nix2vim overlay:
# https://github.com/gytis-ivaskevicius/nix2vim/blob/master/lib/neovim-builder.nix
pkgs.neovimBuilder {
  package = pkgs.neovim-unwrapped;
  inherit colors;

  imports = [
    ../config/colors.nix
    ../config/misc.nix
  ];
}
