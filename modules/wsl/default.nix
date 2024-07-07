{
  config,
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf ( pkgs.stdenv.isLinux && config.wsl.enable ) {
    # Replace config directory with our repo, since it's sourced on every launch
    system.activationScripts.configDir.text = ''
      rm -rf /etc/nixos
      ln --symbolic --no-dereference --force ${config.dotfilesPath} /etc/nixos
    '';
  };
}
