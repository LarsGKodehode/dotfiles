{
  pkgs,
  lib,
  ...
}:

{
  plugins = [
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (
      _plugins: with pkgs.tree-sitter-grammars; [
        tree-sitter-nix
      ]
    ))
  ];

  setup."nvim-treesitter.configs" = {
    highlight.enable = true;
  };
}
