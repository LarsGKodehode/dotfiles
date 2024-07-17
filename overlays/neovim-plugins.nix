inputs: _final: prev:

let
  # Use nixpkgs vimPlugin but with source directly from plugin author
  withSrc =
    pkg: src:
    pkg.overrideAttrs (_: {
      inherit src;
    });

  # Package plugin - for plugins not found in nixpkgs at all
  plugin =
    pname: src:
    prev.vimUtils.buildVimPlugin {
      inherit pname src;
      version = "master";
    };
in
{
  vimPlugins = prev.vimPlugins // {
    # Packaging plugins entirely with Nix
    base16-nvim = plugin "base16-nvim" inputs.base16-nvim-src;
  };
}
