{
  config,
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf pkgs.stdenv.isLinux {
    # System Geo location service
    # https://gitlab.freedesktop.org/geoclue/geoclue
    services.geoclue2.enable = true;

    # Enable the local time based on times zone
    # https://github.com/maxbrunet/automatic-timezoned
    services.automatic-timezoned.enable = true;
  };
}
