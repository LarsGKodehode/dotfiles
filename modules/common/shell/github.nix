{
  config,
  pkgs,
  lib,
  ...
}:

{
  home-manager.users.${config.user} = {

    # Only enable github if git is enabled
    programs.gh = lib.mkIf config.home-manager.users.${config.user}.programs.git.enable {
      enable = true;
      gitCredentialHelper.enable = true;
      settings.git_protocol = "https";
    };
  };
}
