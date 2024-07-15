{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./timezone.nix
  ];

  # Pin state version to prevent warning
  system.stateVersion = config.home-manager.users.${config.user}.home.stateVersion;
}
