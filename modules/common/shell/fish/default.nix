{
  config,
  pkgs,
  lib,
  ...
}:

{
  users.users.${config.user}.shell = pkgs.fish;
  programs.fish.enable = true;

  home-manager.users.${config.user} = {
    programs.fish = {
      enable = true;
      loginShellInit = "";
      shellInit = "";
    };

    home.sessionVariables.fish_greeting = "";
    programs.starship.enableFishIntegration = true;
  };
}
