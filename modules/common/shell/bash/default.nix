{
  config,
  pkgs,
  lib,
  ...
}:

{
  config = {
    home-manager.users.${config.user} = {
      programs.bash = {
        enable = false;
        initExtra = "";
        profileExtra = "";
      };

      programs.starship.enableBashIntegration = true;
    };
  };
}
