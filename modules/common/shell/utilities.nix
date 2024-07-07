{
  config,
  pkgs,
  ...
}:

{
  config = {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        jless # JSON Viewer
        jq # JSON processor
        htmlq # HTML processor
        tree # Visualize directory hierarchy
        ripgrep # grep
        sd # sed
      ];
    };
  };
}
