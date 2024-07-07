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
        enable = true;
        initExtra = "";
        profileExtra = "";
      };

      programs.starship.enableBashIntegration = true;
    };
  };
}
