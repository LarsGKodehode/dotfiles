{
  config,
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf ( pkgs.stdenv.isLinux && config.wsl.enable ) {
    # Set timezone
    services.automatic-timezoned.enable = true;

    # Replace config directory with our repo, since it's sourced on every launch
    system.activationScripts.configDir.text = ''
      rm -rf /etc/nixos
      ln --symbolic --no-dereference --force ${config.dotfilesPath} /etc/nixos
    '';
  };
}
